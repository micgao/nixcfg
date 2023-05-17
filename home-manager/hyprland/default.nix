{ inputs, lib, config, pkgs, ... }: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    wlr-randr
    qt6.qtwayland
    libsForQt5.qt5ct
    libsForQt5.qt5.qtwayland
    nvidia-vaapi-driver
    libva
    hyprpaper
    hyprpicker
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
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
