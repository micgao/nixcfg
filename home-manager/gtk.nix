{ pkgs, config, inputs, ... }:
let
  nix-colors-lib = inputs.nix-colors.lib.contrib { inherit pkgs; };
in
{
  gtk = {
    enable = true;
    font = {
      name = "Inter";
      package = pkgs.google-fonts.override { fonts = [ "Inter" ]; };
      size = 11;
    };
    # cursorTheme = {
    #   name = "Qogir";
    #   package = pkgs.qogir-icon-theme;
    #   size = 24;
    # };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      package = nix-colors-lib.gtkThemeFromScheme {
        scheme = config.colorScheme;
      };
      name = "sequoia";
    };
    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    };
  };
}
