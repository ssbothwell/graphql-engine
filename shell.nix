{ nixpkgs ? import <nixpkgs> {} }:
#{ nixpkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/1aa915c09dfe5d70570a59646df37ea718e93148.tar.gz") {} }:
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
