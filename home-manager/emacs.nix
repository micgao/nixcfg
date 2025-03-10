{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [
    inputs.emacs-overlay.overlay
  ];
  home = {
    packages = with pkgs; [
      unrar
      graphviz
      imagemagick
      texlive.combined.scheme-medium
    ];
  };
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-igc-pgtk.override {
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
