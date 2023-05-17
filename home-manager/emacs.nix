{ inputs, pkgs, lib, ... }: {
  nixpkgs = {
    overlays = [
      inputs.emacs-overlay.overlay
    ];
  };
  home = {
    packages = with pkgs; [
      ((emacsPackagesFor emacsPgtk).emacsWithPackages (epkgs: [ epkgs.vterm ]))
    ];
  };
  services.emacs = {
    enable = true;
    package = with pkgs; ((emacsPackagesFor emacsPgtk).emacsWithPackages (epkgs: [ epkgs.vterm ]));
  };
}
