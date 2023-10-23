{ config, ... }:
{
  programs.gpg = {
    enable = true;
    mutableKeys = true;
    mutableTrust = true;
    homedir = "${config.home.homeDirectory}/.gnupg";
  };
  services.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
    extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';
  };
}
