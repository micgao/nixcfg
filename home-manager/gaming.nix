{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    protontricks
    (lutris.override {extraPkgs = p: [p.libnghttp2];})
    winetricks
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

