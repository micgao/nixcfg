{ pkgs ? import <nixpkgs> { } }: {
  alacritty = pkgs.callPackage ./alacritty { };
  feather-wallet = pkgs.callPackage ./feather-wallet { };
  picocrypt = pkgs.callPackage ./picocrypt { };
  qobuz-dl = pkgs.callPackage ./qobuz-dl { };
  iosevka-ss04 = pkgs.callPackage ./iosevka { };
  wezterm = pkgs.callPackage ./wezterm { };
  geist = pkgs.callPackage ./geist { };
}
