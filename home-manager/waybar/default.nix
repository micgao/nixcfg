{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar-hyprland;
    systemd = {
      enable = true;
    };
  };
  xdg.configFile."waybar/config".source = ./config;
  xdg.configFile."waybar/style.css".source = ./style.css;
  xdg.configFile."waybar/colors.css".source = ./colors.css;
}
