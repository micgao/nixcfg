{ config, ... }: {
  services.mako = {
    enable = true;
    iconPath = "${config.gtk.iconTheme.package}/share/icons/Papirus-Dark";
  };
  xdg.configFile."mako/config".source = ./config;
}
