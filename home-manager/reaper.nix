{ pkgs, ... }:
{
  home.packages = with pkgs; [
    reaper
    yabridge
    yabridgectl
    vital
    airwindows-lv2
  ];
}

