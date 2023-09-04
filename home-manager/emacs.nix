{ inputs, pkgs, config, lib, ... }: 
{
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
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: with epkgs; [
      vterm
    ];
  };
  # services.emacs = {
  #   enable = true;
  # };
}
