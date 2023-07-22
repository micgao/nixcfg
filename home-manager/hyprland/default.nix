{ inputs, lib, config, pkgs, ... }: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  nixpkgs.overlays = [
    inputs.nixpkgs-wayland.overlay
    inputs.hyprpaper.overlays.default
    inputs.hyprpicker.overlays.default
  ];

  home.packages = with pkgs; [
    qt6.qtwayland
    qt6.qt5compat
    libsForQt5.qt5ct
    libsForQt5.breeze-qt5
    libsForQt5.qtstyleplugins
    libsForQt5.qt5.qtwayland
    libsForQt5.polkit-kde-agent
    hyprpaper
    hyprpicker
    imv
    wlay
    wl-clipboard
    wtype
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland.override {
      nvidiaPatches = true;
    };
    systemdIntegration = true;
    recommendedEnvironment = true;
  };
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  xdg.configFile."hypr/mocha.conf".source = ./mocha.conf;
}
