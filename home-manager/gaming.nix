{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    protontricks
    winetricks
    dxvk
    lutris
  ];
  programs.mangohud = {
    enableSessionWide = false;
    enable = true;
    settings = {
      preset = 2;
      time = true;
      gpu_temp = true;
      cpu_temp = true;
    };
  };
}

