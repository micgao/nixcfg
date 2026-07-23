{ inputs, pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    package = inputs.wezterm.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
  xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;
}
