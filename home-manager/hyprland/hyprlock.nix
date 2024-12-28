{ inputs, pkgs, ... }:
{
  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${pkgs.system}.default;
    settings = {
      general = {
        hide_cursor = false;
        no_fade_in = true;
      };
      background = [
        {
          monitor = "";
          path = "/home/micgao/.config/hypr/wallpaper.png";
          color = "rgba(15, 16, 20, 1.0)";
          blur_passes = 3;
          blur_size = 9;
        }
      ];
      input-fields = [
        {
          monitor = "";
          size = {
            width = 300;
            height = 50;
          };
          outline_thickness = 2;
          outer_color = "rgba(19, 19, 23, 1.0)";
          inner_color = "rgba(15, 16, 20, 1.0)";
          font_color = "rgba(134, 134, 144, 1.0)";
          fade_on_empty = false;
          dots_spacing = 0.3;
          dots_center = true;
        }
      ];
    };
  };
}
