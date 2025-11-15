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
      mu
    ];
  };
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-igc-pgtk;
    extraPackages = epkgs: with epkgs; [
      vterm
      mu4e
      treesit-grammars.with-all-grammars
    ];
  };
}
