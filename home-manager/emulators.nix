{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      ryujinx
      yuzu-early-access
    ];
  };
}
