{ inputs, pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    package = inputs.wezterm.packages.${pkgs.system}.default;
  };
  xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;
}
