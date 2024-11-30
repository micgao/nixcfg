{ pkgs ? import <nixpkgs> { } }: {
  qobuz-dl = pkgs.callPackage ./qobuz-dl { };
}
