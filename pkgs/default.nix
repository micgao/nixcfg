{ pkgs ? import <nixpkgs> { } }: {
  alacritty = pkgs.callPackage ./alacritty { };
  feather-wallet = pkgs.callPackage ./feather-wallet { };
  qobuz-dl = pkgs.callPackage ./qobuz-dl { };
  wezterm = pkgs.callPackage ./wezterm { };
  iosevka-ss04 = pkgs.callPackage ./iosevka { };
  # iosevka-murpins = pkgs.callPackage ./iosevka-murpins { };
  inter = pkgs.callPackage ./inter { };
  inkdrop = pkgs.callPackage ./inkdrop { };
}
