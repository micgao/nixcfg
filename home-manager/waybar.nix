{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      layer = "top";
      position = "top";
      height = 26;
      modules-left = [
        "hyprland/workspaces"
      ];
      modules-center = [
        "hyprland/window"
      ];
      modules-right = [
        "tray"
        "battery"
        "clock"
        "cpu"
        "network"
        "pulseaudio"
        "clock"
      ];
      "hyprland/window" = {
        separate-outputs = true;
      };
    };
  };
}
