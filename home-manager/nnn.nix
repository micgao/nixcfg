{ pkgs, ... }:
{
  programs.nnn = {
    enable = true;
    package = pkgs.nnn.override ({ withNerdIcons = true; });
    extraPackages = with pkgs; [ ffmpegthumbnailer mediainfo sxiv ];
  };
}
