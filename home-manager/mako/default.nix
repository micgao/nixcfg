{ inputs, pkgs, config, ... }: {
  nixpkgs = {
    overlays = [
      inputs.nixpkgs-wayland.overlay
    ];
  };
  services.mako = {
    enable = true;
    package = inputs.nixpkgs-wayland.packages."x86_64-linux".mako;
    iconPath = "${config.gtk.iconTheme.package}/share/icons/Dracula";
  };
  xdg.configFile."mako/config".source = ./config;
}
