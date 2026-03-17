{ pkgs, config, ... }:
{
  gtk = {
    enable = true;
    font = {
      name = "Inter";
      size = 11;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    };
  };
}
