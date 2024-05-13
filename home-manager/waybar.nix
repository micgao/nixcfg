{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      primary = {
        exclusive = false;
        passthrough = false;
        fixed-center = true;
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
          "systemd-failed-units"
          "battery"
          "cpu"
          "memory"
          "disk"
          "network"
          "clock"
        ];
        "hyprland/window" = {
          separate-outputs = true;
        };
        "battery" = {
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
        };
        "tray" = {
          show-passive-items = true;
        };
        "disk" = {
          interval = 30;
          format = "{used}/{total}";
        };
        "memory" = {
          interval = 30;
          format = "{percentage}%  ";
        };
        "clock" = {
          interval = 60;
          format = "{:%H:%M}";
          format-alt = "{:%A, %B %d, %Y (%R)}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };
      };
    };
  };
}
