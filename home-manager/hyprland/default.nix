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

  services.hyprlauncher = {
    enable = true;
    package = inputs.hyprlauncher.packages.${pkgs.stdenv.hostPlatform.system}.hyprlauncher;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    package = null;
    portalPackage = null;
    xwayland.enable = true;
    extraConfig = ''
      require("settings")
    '';
    systemd = {
      enable = true;
    };
  };

  xdg.configFile."hypr/wallpaper.png".source = ./wallpaper.png;
  xdg.configFile."hypr/hyprqt6engine.conf".source = ./hyprqt6engine.conf;
  xdg.configFile."hypr/hyprtoolkit.conf".source = ./hyprtoolkit.conf;
}
