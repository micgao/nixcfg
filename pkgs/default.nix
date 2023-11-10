{ pkgs ? import <nixpkgs> { } }: {
  alacritty = pkgs.callPackage ./alacritty { };
  feather-wallet = pkgs.callPackage ./feather-wallet { };
  picocrypt = pkgs.callPackage ./picocrypt { };
  qobuz-dl = pkgs.callPackage ./qobuz-dl { };
  wezterm = pkgs.callPackage ./wezterm { };
  iosevka-ss04 = pkgs.callPackage ./iosevka { };
  geist = pkgs.callPackage ./geist { };
  inter = pkgs.callPackage ./inter { };
  monaspace = pkgs.callPackage ./monaspace { };
}
