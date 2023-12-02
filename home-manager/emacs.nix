{ inputs, pkgs, ... }: 
{
  nixpkgs.overlays = [
    inputs.emacs-overlay.overlay
  ];
  home = {
    packages = with pkgs; [
      binutils
      xdg-utils
      unrar
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
    package = pkgs.emacs-pgtk.override {
      withNativeCompilation = true;
      withTreeSitter = true;
    };
    extraPackages = epkgs: with epkgs; [
      emacsql
      vterm
      mu4e
      lsp-mode
    ];
  };
}
