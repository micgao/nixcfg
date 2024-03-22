{ config, pkgs, inputs, ... }: {
  nixpkgs.overlays = [
    inputs.nix-your-shell.overlays.default
  ];
  home = {
    packages = [ pkgs.nix-your-shell ];
  };
  home.file."${config.xdg.configHome}/nushell/nix-your-shell.nu".source = pkgs.nix-your-shell.generate-config "nu";
}
