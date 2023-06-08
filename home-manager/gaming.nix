{ pkgs, lib, ... }:
let
  steam-with-pkgs = pkgs.steam.override {
    extraPkgs = pkgs: with pkgs; [
      xorg.libXcursor
      xorg.libXi
      xorg.libXinerama
      xorg.libXScrnSaver
      libpng
      libpulseaudio
      libvorbis
      stdenv.cc.cc.lib
      libkrb5
      keyutils
    ];
  };
in
{
  home.packages = with pkgs; [
    steam-with-pkgs
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
      gamemode = true;
      vkbasalt = true;
      media_player = true;
      horizontal = true;
    };
  };
}

