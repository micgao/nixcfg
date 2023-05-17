{ inputs, pkgs, lib, ... }: {
  nixpkgs = {
    overlays = [
      inputs.nixpkgs-wayland.overlay
    ];
  };
  home = {
    packages = with pkgs; [
      inputs.nixpkgs-wayland.packages.${system}.mako
    ];
  };
}
