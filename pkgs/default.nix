{ pkgs ? import <nixpkgs> { } }: {
  qobuz-dl = pkgs.callPackage ./qobuz-dl { };
  iosevka-ss04 = pkgs.callPackage ./iosevka { };
  # iosevka-murpins = pkgs.callPackage ./iosevka-murpins { };
  inter = pkgs.callPackage ./inter { };
}
