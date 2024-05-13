{ input, pkgs, ... }:
{
  programs.hyprlock = {
    enable = true;
    package = input.hyprlock.packages.${pkgs.hostPlatform.system}.default;
  };
}
