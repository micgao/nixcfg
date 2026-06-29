{ config, ... }:
{
  programs.gpg = {
    enable = true;
    mutableKeys = true;
    mutableTrust = true;
    homedir = "${config.home.homeDirectory}/.gnupg";
  };
}
