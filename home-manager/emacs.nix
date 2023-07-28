{ inputs, pkgs, lib, ... }: {
  nixpkgs = {
    overlays = [
      inputs.emacs-overlay.overlay
    ];
  };
  home = {
    packages = with pkgs; [
      emacs-all-the-icons-fonts
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
    package = with pkgs; ((emacsPackagesFor emacs-pgtk).emacsWithPackages (epkgs: [ epkgs.vterm epkgs.emacsql-sqlite ]));
  };
  services.emacs = {
    enable = true;
    socketActivation.enable = true;
    package = with pkgs; ((emacsPackagesFor emacs-pgtk).emacsWithPackages (epkgs: [ epkgs.vterm epkgs.emacsql-sqlite ]));
  };
}
