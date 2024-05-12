{ pkgs ? import <nixpkgs> { } }: {
  qobuz-dl = pkgs.callPackage ./qobuz-dl { };
  iosevka-ss04 = pkgs.callPackage ./iosevka { };
}
