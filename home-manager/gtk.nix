{ pkgs, config, inputs, ... }:
let
  nix-colors-lib = inputs.nix-colors.lib.contrib { inherit pkgs; };
in
{
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Qogir";
      package = pkgs.qogir-icon-theme;
      size = 24;
    };
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
    font = {
      name = "Inter";
      package = pkgs.google-fonts.override {fonts = ["Inter"];};
      size = 9;
    };
    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      extraConfig = ''
        gtk-xft-antialias=1
        gtk-xft-hinting=1
        gtk-xft-hintstyle="hintmedium"
        gtk-xft-rgba="rgb"
      '';
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintmedium";
      gtk-xft-rgba = "rgb";
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintmedium";
      gtk-xft-rgba = "rgb";
    };
  };
}
