{ inputs, pkgs, lib, ... }: {
  nixpkgs = {
    overlays = [
      inputs.emacs-overlay.overlay
    ];
  };
  programs.emacs = {
    enable = true;
    package = with pkgs; ((emacsPackagesFor emacs-pgtk).emacsWithPackages (epkgs: [ epkgs.vterm ]));
  };
  services.emacs = {
    enable = true;
    package = with pkgs; ((emacsPackagesFor emacs-pgtk).emacsWithPackages (epkgs: [ epkgs.vterm ]));
  };
}
