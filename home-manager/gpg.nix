{ config, pkgs, inputs, ... }:
{
  programs.gpg = {
    enable = true;
    mutableKeys = true;
    mutableTrust = true;
    homedir = "${config.home.homeDirectory}/.gnupg";
  };
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    pinentryPackage = inputs.nixpkgs-wayland.outputs.packages.${pkgs.stdenv.hostPlatform.system}.wayprompt;
  };
}
