{ inputs, pkgs, config, lib, ... }:
{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./hyprpaper.nix
    # ./hyprlock.nix
  ];

  home.packages = [
    inputs.hyprpicker.packages.${pkgs.stdenv.hostPlatform.system}.hyprpicker
    inputs.hyprqt6engine.packages.${pkgs.stdenv.hostPlatform.system}.hyprqt6engine
  ];

  programs.hyprland-qt-support.enable = true;

  services.hyprpolkitagent = {
    enable = true;
    package = inputs.hyprpolkitagent.packages.${pkgs.stdenv.hostPlatform.system}.hyprpolkitagent;
  };

  # services.hypridle = {
  #   enable = true;
  #   package = inputs.hypridle.packages.${pkgs.stdenv.hostPlatform.system}.hypridle;
  #   settings = {
  #     general = {
  #       lock_cmd = "${lib.getExe config.programs.hyprlock.package}";
  #     };
  #   };
  # };

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
    systemd = {
      enable = true;
      variables = [
        "--all"
      ];
      enableXdgAutostart = true;
    };
  };

  xdg.configFile."hypr/wallpaper.png".source = ./wallpaper.png;
  xdg.configFile."hypr/hyprland.lua".source = ./hyprland.lua;
  xdg.configFile."hypr/hyprqt6engine.conf".source = ./hyprqt6engine.conf;
  xdg.configFile."hypr/hyprtoolkit.conf".source = ./hyprtoolkit.conf;
}
