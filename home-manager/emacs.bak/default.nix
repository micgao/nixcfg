{ inputs, pkgs, config, lib, ... }: 
{
  imports = [
    inputs.nix-doom-emacs.hmModule
  ];
  nixpkgs.overlays = [
    inputs.emacs-overlay.overlay
  ];
  home = {
    packages = with pkgs; [
      xorg.xprop
      xorg.xwininfo
      xdotool
      binutils
      xdg-utils
      graphviz
      imagemagick
      zstd
      sqlite
      editorconfig-core-c
      gnutls
      texlive.combined.scheme-medium
    ];
  };
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom;
    emacsPackage = pkgs.emacs-pgtk;
  };
  # programs.emacs = {
  #   enable = true;
  #   package = with pkgs; emacs-pgtk.override { withTreeSitter = true; withSQLite3 = true; withWebP = true; withPgtk = true; withNativeCompilation = true; };
  #   extraPackages = epkgs: with epkgs; [
  #     vterm
  #   ];
  # };
  services.emacs = {
    enable = true;
  };
}
