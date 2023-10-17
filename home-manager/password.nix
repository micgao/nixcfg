{ pkgs, config, ... }:
{
  programs = {
    password-store = {
      enable = true;
      package = pkgs.pass-wayland.withExtensions (exts: [exts.pass-otp exts.pass-import exts.pass-update exts.pass-tomb]);
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
