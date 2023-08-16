{ inputs, pkgs, lib, ... }: 
{
  nixpkgs = {
    overlays = [
      inputs.emacs-overlay.overlay
    ];
  };
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
    package = with pkgs; ((emacsPackagesFor (emacs-pgtk.override { withTreeSitter = true; })).emacsWithPackages (epkgs: [ epkgs.vterm ]));
  };
  services.emacs = {
    enable = true;
    socketActivation.enable = true;
    package = with pkgs; ((emacsPackagesFor (emacs-pgtk.override { withTreeSitter = true; })).emacsWithPackages (epkgs: [ epkgs.vterm ]));
  };
}
