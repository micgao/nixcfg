{ inputs, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.system}.default;
    settings = {
      wallpaper = {
        path = "/home/micgao/.config/hypr/wallpaper.png";
        monitor = "DP-3";
      };
      splash = false;
    };
  };
}
