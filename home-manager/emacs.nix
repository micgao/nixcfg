{ inputs, pkgs, ... }: {
  nixpkgs = {
    overlays = [
      inputs.emacs-overlay.overlay
    ];
  };
  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtk;
  };
  services.emacs = {
    enable = true;
    package = pkgs.emacsPgtk;
  };
}
