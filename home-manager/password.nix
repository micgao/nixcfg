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
  services = {
    gnome-keyring ={
      enable = true;
      components = [ "pkcs11" "secrets" "ssh" ];
    };
  };
}
