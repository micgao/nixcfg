{ inputs, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.system}.default;
    settings = {
      preload = [
        "/home/micgao/.config/hypr/wallpaper.jpg"
      ];
      wallpaper = [
        ",/home/micgao/.config/hypr/wallpaper.jpg"
      ];
      splash = false;
    };
  };
}
