{ inputs, pkgs, config, lib, ... }: 
{
  nixpkgs.overlays = [
    inputs.emacs-overlay.overlay
  ];
  home = {
    packages = with pkgs; [
      binutils
      xdg-utils
      unrar
      zip
      unzip
      p7zip
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
      mu4e
    ];
  };
  # services.emacs = {
  #   enable = true;
  # };
}
