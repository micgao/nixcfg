{ pkgs ? import <nixpkgs> { } }: {
  feather-wallet = pkgs.callPackage ./feather-wallet { };
  picocrypt = pkgs.callPackage ./picocrypt { };
}
