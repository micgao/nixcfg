{ pkgs ? import <nixpkgs> { } }: {
  feather-wallet = pkgs.callPackage ./feather-wallet { };
  picocrypt = pkgs.callPackage ./picocrypt { };
  qobuz-dl = pkgs.callPackage ./qobuz-dl { };
  iosevka-ss04 = pkgs.callPackage ./iosevka { };
}
