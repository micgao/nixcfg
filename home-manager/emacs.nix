{ inputs, pkgs, lib, ... }: 
{
  nixpkgs = {
    overlays = [
      inputs.emacs-overlay.overlay
    ];
  };
  home = {
    packages = with pkgs; [
      binutils
      xdg-utils
      (ripgrep.override {withPCRE2 = true;})
      graphviz
      fd
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
    package = with pkgs; ((emacsPackagesFor (emacs-pgtk.override { withTreeSitter = true; })).emacsWithPackages (epkgs: [ epkgs.vterm epkgs.emacsql-sqlite epkgs.emacsql ]));
  };
  services.emacs = {
    enable = true;
    socketActivation.enable = true;
    package = with pkgs; ((emacsPackagesFor (emacs-pgtk.override { withTreeSitter = true; })).emacsWithPackages (epkgs: [ epkgs.vterm epkgs.emacsql-sqlite epkgs.emacsql ]));
  };
}
