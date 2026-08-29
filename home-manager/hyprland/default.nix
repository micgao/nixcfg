{ inputs, pkgs, config, lib, ... }:
{
  imports = [
    inputs.hyprland.homeManagerModules.default
    # ./hyprpaper.nix
    # ./hyprlock.nix
  ];

  home.packages = [
    inputs.hyprpicker.packages.${pkgs.stdenv.hostPlatform.system}.hyprpicker
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    package = null;
    portalPackage = null;
    xwayland.enable = true;
    systemd.enable = false;
  };

  xdg.configFile."hypr/wallpaper.png".source = ./wallpaper.png;
  xdg.configFile."hypr/hyprqt6engine.conf".source = ./hyprqt6engine.conf;
  xdg.configFile."hypr/hyprtoolkit.conf".source = ./hyprtoolkit.conf;
  xdg.configFile."hypr/hyprland.lua".source = ./hyprland.lua;
}
