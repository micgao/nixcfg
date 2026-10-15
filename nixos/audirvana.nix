{ config, lib, pkgs, ... }:
let
  package = pkgs.audirvana-studio;
  remoteServerPort = 30800;
  upnpServerPort = 30801;
  adminConfig = pkgs.writeText "audirvana-adminconfig.json" (builtins.toJSON {
    inherit remoteServerPort upnpServerPort;
  });
in
{
  environment.systemPackages = [ package ];

  security.wrappers.audirvana-studio = {
    source = lib.getExe package;
    capabilities = "cap_sys_nice+ep";
    owner = "root";
    group = "root";
  };

  systemd.user.services.audirvana-studio = {
    description = "Audirvāna Studio";
    # wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStartPre = "${pkgs.coreutils}/bin/install -Dm644 ${adminConfig} %E/audirvana/adminconfig.json";
      ExecStart = "${config.security.wrapperDir}/audirvana-studio";
      Restart = "on-failure";
    };
  };

  services.avahi = {
    enable = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ remoteServerPort upnpServerPort ];
}
