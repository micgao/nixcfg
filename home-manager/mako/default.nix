{ inputs, pkgs, config, ... }: {
  services.mako = {
    enable = true;
  };
  xdg.configFile."mako/config".source = ./config;
}
