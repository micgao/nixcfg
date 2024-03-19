{ config, pkgs, inputs, ... }: {
  nixpkgs.overlays = [
    inputs.nix-your-shell.overlays.default
  ];
  home = {
    packages = [ pkgs.nix-your-shell ];
  };
}
