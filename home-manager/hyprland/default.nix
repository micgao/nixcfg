{ inputs, lib, config, pkgs, ... }: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  nixpkgs.overlays = [
    inputs.nixpkgs-wayland.overlay
  ];

  home.packages = with pkgs; [
    qt6.qtwayland
    libsForQt5.qt5ct
    libsForQt5.qt5.qtwayland
    hyprpaper
    hyprpicker
    imv
    kanshi
    wlay
    wl-clipboard
    wtype
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    systemdIntegration = true;
    disableAutoreload = true;
    xwayland = {
      enable = true;
      hidpi = false;
    };
    nvidiaPatches = true;
    recommendedEnvironment = true;
  };
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
}
