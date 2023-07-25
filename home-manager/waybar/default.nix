{ pkgs, inputs, ... }: {
  nixpkgs.overlays = [
    inputs.hyprland.overlays.default
  ];
  programs.waybar = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.waybar-hyprland;
    # package = inputs.nixpkgs-wayland.packages.${pkgs.system}.waybar.overrideAttrs (oa: {
    #   mesonFlags = (oa.mesonFlags or  [ ]) ++ [ "-Dexperimental=true" ];
    # });
    systemd = {
      enable = true;
    };
  };
  xdg.configFile."waybar/config".source = ./config;
  xdg.configFile."waybar/style.css".source = ./style.css;
  xdg.configFile."waybar/mocha.css".source = ./mocha.css;
}
