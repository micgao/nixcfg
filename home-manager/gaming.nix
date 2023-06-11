{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    protontricks
    (lutris.override {extraPkgs = p: [p.libnghttp2];})
    gamescope
    gamemode
    winetricks
  ];
  programs.mangohud = {
    enable = true;
    settings = {
      preset = 2;
      time = true;
      media_player = true;
      gpu_temp = true;
      cpu_temp = true;
    };
  };
}

