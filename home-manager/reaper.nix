{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    reaper
    # yabridge
    # yabridgectl
  ];
}

