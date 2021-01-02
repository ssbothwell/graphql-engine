let
  nixpkgsPath = builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/99600888934d1804840e06a680699dedc05eea10.tar.gz";
  pkgs = import nixpkgsPath { inherit config; };

  # Parse version constraints from cabal.project.freeze
  # I wish Nix had a ($) or (.) operator
  versionConstraints =
    # Merge a list of key/value pairs into one big attrset
    builtins.listToAttrs
      (
        # Convert every match to { name = "foo"; value = "1.2.3"; }
        builtins.map
          (
            versionConstraint:
            {
              name = builtins.elemAt versionConstraint 0;
              value = builtins.elemAt versionConstraint 1;
            }
          )
          (
            # Filter away everything but matches to get [ [package version] ... ].
            builtins.filter
              builtins.isList
              (
                # Return matches of the regex interleaved with strings in between.
                # > builtins.split "(a)" "banana"
                # ["b" ["a"] "n" ["a"] "n" ["a"]]
                builtins.split "any\.([[:alnum:]-]+) ==([[:digit:].]+)"
                  (builtins.readFile ./cabal.project.freeze)
              )
          )
      );

  compiler = "ghc8102";
  config = {
    packageOverrides = pkgs: {
      haskellPackages = pkgs.haskell.packages.${compiler}.override {
        overrides =
          let
            # An overlay that simply introduces packages from cabal.project.freeze
            cabalFreeze = self: super:
              let
                pinnedPackages = pkgs.lib.mapAttrs
                  (
                    package: version:
                      # Disable tests since test dependencies are missing from cabal.project.freeze
                      pkgs.haskell.lib.dontCheck (
                        self.callHackage package version { }
                      )
                  )
                  versionConstraints;
              in
              builtins.removeAttrs pinnedPackages [
                # Core libraries cannot be built with callHackage since they are provided by ghc.
                # See pkgs/development/haskell-modules/configuration-ghc-8.10.x.nix
                "array"
                "base"
                "binary"
                "bytestring"
                "Cabal"
                "containers"
                "deepseq"
                "directory"
                "exceptions"
                "filepath"
                "ghc-boot"
                "ghc-boot-th"
                "ghc-compact"
                "ghc-heap"
                "ghc-prim"
                "ghci"
                "haskeline"
                "hpc"
                "integer-gmp"
                "libiserv"
                "mtl"
                "parsec"
                "pretty"
                "process"
                "rts"
                "stm"
                "template-haskell"
                "terminfo"
                "text"
                "time"
                "transformers"
                "unix"
                "xhtml"
              ];
            # An overlay that adds graphql and fixes small innacuracies from cabalFreeze
            graphql = self: super: {
              # Prevent changing cabal2nix to avoid infinite recursion
              # callHackage -> cabal2nix -> libraries cabalFreeze overrides -> callHackage
              cabal2nix =
                let vanillaPkgs = import nixpkgsPath { }; in
                vanillaPkgs.haskell.packages.${compiler}.cabal2nix;

              # Prevent infinite recursion since zlib-the-haskell-package depends on a zlib-the-C-package,
              # and callHackage doesn't know that.
              zlib = super.zlib.override {
                inherit (pkgs) zlib;
              };

              # This library can't be built with profiling.
              ghc-heap-view = pkgs.haskell.lib.disableLibraryProfiling super.ghc-heap-view;

              graphql-parser = self.callCabal2nix "graphql-parser-hs"
                (pkgs.fetchFromGitHub {
                  owner = "hasura";
                  repo = "graphql-parser-hs";
                  rev = "f3a20ab6201669bd683d5a0c8580410af264c7d0";
                  sha256 = "07pc1ig36bk1dd9nvb4pyqxz7mblm59iai5gmpwa1xzwjyqlg3y0";
                })
                { };

              resource-pool = self.callCabal2nix "resource-pool"
                (pkgs.fetchFromGitHub {
                  owner = "hasura";
                  repo = "pool";
                  rev = "0fdfaed4e109ca6a6bf00ed6d79c329626e3bdd4";
                  sha256 = "1298v5x8lrrvvd5z9wkdyvi76v30zhd3kcbjhryz6gws2mhgpg3a";
                })
                { };

              pg-client = self.callPackage ./pg-client.nix { };

              graphql-engine = self.callPackage ./graphql-engine.nix { };
            };
          in
          # This function lets you compose overlays (functions of the form `self: super: {...}`)
          pkgs.lib.composeExtensions cabalFreeze graphql;
      };
    };
  };
in
pkgs
