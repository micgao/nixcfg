{ pkgs, ... }:
{
  home.packages = with pkgs; [
    protontricks
    gamemode
    (lutris.override {extraPkgs = p: [p.libnghttp2];})
    winetricks
  ];
}

