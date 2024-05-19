{
  programs.waybar = {
    enable = true;
    style = ''
      @define-color foreground #868690;
      @define-color background #0F1014;
      @define-color blue #8EB5F5;
      @define-color indigo #C58FFF;
      @define-color pink #F58EE0;
      @define-color orange #FFBB88;
      @define-color stone #9898A6;
      @define-color metal #FDFDFE;

      * {
          font-family: 'Inter', 'Source Sans Pro', sans-serif;
          font-size: 12.5px;
      }

      window#waybar {
          background: transparent;
          color: @foreground;
          transition-property: background-color;
          transition-duration: .5s;
      }

      tooltip {
        background: rgba(43, 48, 59, 0.5);
        border: 1px solid rgba(100, 114, 125, 0.5);
      }

      tooltip label {
        color: @foreground;
      }

      #tray {
        margin: 4px 4px 4px 4px;
        border-radius: 4px;
        background-color: @background;
      }

      #tray * {
        padding: 0 6px;
        border-left: 1px solid @transparency;
      }

      #tray *:first-child {
        border-left: none;
      }

      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: @foreground;
          border-bottom: 3px solid @blue;
      }

      #workspaces button.active {
          background: transparent;
          border-bottom: 3px solid @orange;
      }

      #clock, #battery, #cpu, #memory, #disk, #systemd-failed-units, #network, #pulseaudio, #wireplumber {
          margin: 4px 2px;
          background-color: @background;
          border-radius: 4px;
          min-width: 20px;
          padding: 0 6px;
      }

      #window {
          background-color: transparent;
      }
    '';
    systemd.enable = true;
    settings = {
      primary = {
        exclusive = true;
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
          format-icons = [ "" "" "" "" "" ];
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
