{ inputs, pkgs, config, ... }: {
  nixpkgs = {
    overlays = [
      inputs.nixpkgs-wayland.overlay
    ];
  };
  home = {
    packages = with pkgs; [
      inputs.nixpkgs-wayland.packages.${system}.wofi
    ];
  };
  xdg.configFile."wofi/config".source = ./config;
  xdg.configFile."wofi/style.css".source = ./style.css;
}
