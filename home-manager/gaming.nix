{ pkgs, ... }:
{
  home.packages = with pkgs; [
    protontricks
    winetricks
  ];
  programs.mangohud = {
    enable = true;
    enableSessionWide = false;
  };
}

