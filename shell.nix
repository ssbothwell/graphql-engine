{ nixpkgs ? import <nixpkgs> {} }:
let
  inherit (nixpkgs) pkgs;
  project = import ./server/release.nix;
in
pkgs.stdenv.mkDerivation {
  name = "shell";
  buildInputs = project.env.nativeBuildInputs ++ [
    pkgs.nodejs
    pkgs.nodePackages.npm
    pkgs.haskellPackages.cabal-install
    pkgs.zlib.dev
    pkgs.openssl
    pkgs.postgresql
    pkgs.postgresql.lib
    pkgs.docker
    pkgs.kerberos.dev
    pkgs.google-cloud-sdk
    pkgs.font-awesome
  ];
}
