{ pkgs ? import <nixpkgs> { } }: {
  feather-wallet = pkgs.callPackage ./feather-wallet { };
  qobuz-dl = pkgs.callPackage ./qobuz-dl { };
  iosevka-ss04 = pkgs.callPackage ./iosevka { };
  # iosevka-murpins = pkgs.callPackage ./iosevka-murpins { };
  inter = pkgs.callPackage ./inter { };
}
