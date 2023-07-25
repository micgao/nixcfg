{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    protontricks
    winetricks
    lutris
  ];
  programs.mangohud = {
    enable = true;
    enableSessionWide = false;
    settings = {
      preset = 2;
      time = true;
      gpu_temp = true;
      cpu_temp = true;
    };
  };
}

