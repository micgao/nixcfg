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
    };
  };
}
