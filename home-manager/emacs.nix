{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [
    inputs.emacs-overlay.overlay
  ];
  home = {
    packages = with pkgs; [
      binutils
      xdg-utils
      xdg-user-dirs
      unrar
      graphviz
      imagemagick
      zstd
      gnutls
      texlive.combined.scheme-medium
    ];
  };
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk.override {
      withNativeCompilation = true;
      withTreeSitter = true;
      withPgtk = true;
      withSQLite3 = true;
      withSystemd = true;
      withSmallJaDic = true;
    };
    extraPackages = epkgs: with epkgs; [
      vterm
      mu4e
      treesit-grammars.with-all-grammars
    ];
  };
}
