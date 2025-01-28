{ pkgs, config, ... }:
{
  programs = {
    password-store = {
      enable = true;
      package = pkgs.gopass;
      settings = {
        PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
      };
    };
  };
}
