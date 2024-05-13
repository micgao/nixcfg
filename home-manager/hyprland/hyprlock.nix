{ inputs, pkgs, ... }:
{
  inports = [
    inputs.hyprlock.homeManagerModules.default
  ];
  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${pkgs.hostPlatform.system}.default;
  };
}
