{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.override {
      cavaSupport = true;
      hyprlandSupport = true;
      inputSupport = true;
      jackSupport = true;
      mpdSupport = true;
      mprisSupport = true;
      nlSupport = true;
      pulseSupport = true;
      sndioSupport = true;
      traySupport = true;
      udevSupport = true;
      wireplumberSupport = true;
    };
  };
  xdg.configFile."waybar/config".source = ./config;
  xdg.configFile."waybar/style.css".source = ./style.css;
  xdg.configFile."waybar/colors.css".source = ./colors.css;
}
