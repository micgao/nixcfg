{ inputs, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      wallpaper = {
        path = "/home/micgao/.config/hypr/wallpaper.png";
        monitor = "DP-3";
      };
      splash = false;
    };
  };
}
