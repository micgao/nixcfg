{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config.theme = "Catppuccin-Mocha";
    themes = {
      Catppuccin-Mocha = builtins.readFile (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-mocha.tmTheme";
        hash = "sha256-qMQNJGZImmjrqzy7IiEkY5IhvPAMZpq0W6skLLsng/w=";
      });
    };
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batwatch
    ];
  };
}
