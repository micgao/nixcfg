{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    protontricks
    winetricks
    (lutris.override { extraPkgs = p: [p.wine]; })
    protonup-ng
    vkbasalt
    gnome.zenity
  ];
  programs.mangohud = {
    enable = true;
    enableSessionWide = false;
    settings = {
      preset = 2;
      time = true;
      time_format = "%H:%M";
      gpu_temp = true;
      cpu_temp = true;
    };
  };
}

