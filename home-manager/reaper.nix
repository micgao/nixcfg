{ pkgs, ... }:
{
  home.packages = with pkgs; [
    reaper
    vital
    airwindows-lv2
  ];
}

