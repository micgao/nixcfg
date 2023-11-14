{ pkgs, ... }:
{
  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      name = "gtk2";
      package = pkgs.qt6Packages.qt6gtk2;
    };
  };
  xdg.configFile."qt5ct/colors/Catppuccin-Mocha.conf".source = ./Catppuccin-Mocha.conf;
  xdg.configFile."qt5ct/colors/sequoia.conf".source = ./sequoia.conf;
}
