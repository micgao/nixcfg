{ pkgs, ... }:
{
  programs.nnn = {
    enable = true;
    package = pkgs.nnn.override ({ withNerdIcons = true; withPcre = true; });
    extraPackages = with pkgs; [ ffmpegthumbnailer mediainfo sxiv ];
  };
}
