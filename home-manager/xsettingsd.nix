{ config, ... }:
{
  services = {
    xsettingsd = {
      enable = true;
      settings = {
        "Net/IconThemeName" = "${config.gtk.iconTheme.name}";
        "Net/ThemeName" = "${config.gtk.theme.name}";
      };
    };
  };
}
