let
  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskell.packages.ghc8102.override {
        overrides = haskellPackagesNew: haskellPackagesOld: rec {
          graphql-parser = haskellPackagesNew.callCabal2nix "graphql-parser-hs" (pkgs.fetchFromGitHub {
            owner = "hasura";
            repo = "graphql-parser-hs";
            rev = "f2e51dbde21ad1c596f659144128d80b69254e98";
            sha256 = "05mvp3f5zhpwxk3hp52n3zis5w7cd6mkhxf844cbd1s63jqzl9i2";
          }){ };

          resource-pool = haskellPackagesNew.callCabal2nix "resource-pool" (pkgs.fetchFromGitHub {
            owner = "hasura";
            repo = "pool";
            rev = "0fdfaed4e109ca6a6bf00ed6d79c329626e3bdd4";
            sha256 = "1298v5x8lrrvvd5z9wkdyvi76v30zhd3kcbjhryz6gws2mhgpg3a";
          }){ };

          pg-client = haskellPackagesNew.callPackage ./pg-client.nix { };
          ci-info-hs = haskellPackagesNew.callPackage ./ci-info-hs.nix { };
          immortal = haskellPackagesNew.callPackage ./immortal.nix { };
          dependent-map = pkgs.haskell.lib.doJailbreak haskellPackagesOld.dependent-map;
          #base16-bytestring = haskellPackagesOld.base16-bytestring_1_0_1_0;
          #unordered-containers = haskellPackagesNew.callPackage ./unordered-containers.nix { };
          #aeson = haskellPackagesNew.callPackage ./aeson.nix { };
        };
      };
    };
  };
  #pkgs = import <nixpkgs> { inherit config; };
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/1aa915c09dfe5d70570a59646df37ea718e93148.tar.gz") { inherit config; };
in
  pkgs.haskellPackages.callPackage ./default.nix { }
#{
#  pg-client = pkgs.haskellPackages.pg-client;
#  #hasura = pkgs.haskellPackages.hasura;
#}


#let
#  pkgs = import <nixpkgs> { };
#  hs = pkgs.haskell.packages.ghc8102.extend(self: super:
#    with pkgs.haskell.lib; {
#    hasura = self.callPackage ./default.nix { };
#    immortal = self.callPackage ./immortal.nix { };
#    pg-client-hs = self.callPackage ./derp.nix { };
#    #pg-client-hs = self.callCabal2nix "pg-client-hs" (pkgs.fetchFromGitHub {
#    #  owner = "hasura";
#    #  repo = "pg-client-hs";
#    #  rev = "633a06ba9c1e6a561b0ad0d25951fcdf6dd054ca";
#    #  sha256 = "0000000000000000000000000000000000000000";
#    #}){ };

#    graphql-parser = self.callCabal2nix "graphql-parser-hs" (pkgs.fetchFromGitHub {
#      owner = "hasura";
#      repo = "graphql-parser-hs";
#      rev = "a19a4bfcf295a832f6636fb957c2338444c6d486";
#      sha256 = "1911lgwsxpphxngr7yn6kma4y5va1nlyczps65cxfz4hw070d3v5";
#    }){ };
#
#    ci-info-hs = self.callPackage ./ci-info-hs.git { };
#    pool = self.callPackage ./pool.nix { };
#    dependent-map = pkgs.haskell.lib.doJailbreak pkgs.haskell.packages.ghc8102.dependent-map;
#  });
#in { inherit (hs) hasura; }
