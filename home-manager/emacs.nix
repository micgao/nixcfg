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
    package = pkgs.emacs-git-pgtk;
    extraPackages = epkgs: with epkgs; [
      vterm
      mu4e
      treesit-grammars.with-all-grammars
    ];
  };
}
