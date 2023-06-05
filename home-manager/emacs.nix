{ inputs, pkgs, lib, ... }: {
  nixpkgs = {
    overlays = [
      inputs.emacs-overlay.overlay
    ];
  };
  home = {
    packages = with pkgs; [
      ((emacsPackagesFor emacs-pgtk).emacsWithPackages (epkgs: [ epkgs.vterm ]))
    ];
  };
  services.emacs = {
    enable = true;
    package = with pkgs; ((emacsPackagesFor emacs-pgtk).emacsWithPackages (epkgs: [ epkgs.vterm ]));
  };
}
