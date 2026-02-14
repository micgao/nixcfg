{ pkgs, ... }:
{
  home.packages = with pkgs; [
    protontricks
    winetricks
    protonup-ng
    vkbasalt
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

