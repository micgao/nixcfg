{ pkgs, config, ... }:
{
  programs = {
    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [exts.pass-otp]);
      settings = {
        PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.local/share/password-store";
      };
    };
  };
  services = {
    pass-secret-service ={
      enable = true;
    };
  };
}
