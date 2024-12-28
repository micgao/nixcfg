{ inputs, pkgs, lib, ... }:
{
  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.system}.default;
    settings = {
      preload = [
        "/home/micgao/.config/hypr/wallpaper.png"
      ];
      wallpaper = [
        ",/home/micgao/.config/hypr/wallpaper.png"
      ];
      splash = false;
    };
  };
  systemd.user.services.hyprpaper.Unit.After = lib.mkForce "graphical-session.target";
}
