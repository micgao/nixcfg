{
  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      name = "breeze";
    };
  };
  xdg.configFile."qt5ct/colors/Catppuccin-Mocha.conf".source = ./Catppuccin-Mocha.conf;
  xdg.configFile."qt5ct/colors/sequoia.conf".source = ./sequoia.conf;
}
