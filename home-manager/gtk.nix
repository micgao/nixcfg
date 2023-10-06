{ pkgs, config, inputs, ... }:
let
  nix-colors-lib = inputs.nix-colors.lib.contrib { inherit pkgs; };
in {
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
      # package = nix-colors-lib.gtkThemeFromScheme {
      #   scheme = config.colorScheme;
      # };
      # name = "Sequoia";
      name = "Catppuccin-Mocha-Compact-Flamingo-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "flamingo" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
    };
    font = {
      name = "Roboto";
      package = pkgs.roboto;
      size = 9.75;
    };
    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
}
