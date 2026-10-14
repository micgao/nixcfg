{ config, lib, pkgs, ... }:

# Audirvāna Studio runs headless and is controlled from the Audirvāna Remote
# app. This replaces the vendor's setAsService.sh with a user service, so it
# plays through the logged-in session's audio and keeps its state in
# ~/.config/audirvana and ~/.local/share/audirvana.
let
  package = pkgs.audirvana-studio;

  # Audirvāna picks a random port for the Remote app unless one is set here.
  # Fixing it lets the firewall open just this port.
  remoteServerPort = 30800;
  # Serves audio to UPnP/DLNA renderers on the network.
  upnpServerPort = 30801;

  adminConfig = pkgs.writeText "audirvana-adminconfig.json" (builtins.toJSON {
    inherit remoteServerPort upnpServerPort;
  });
in
{
  environment.systemPackages = [ package ];

  # The .deb's postinst does `setcap cap_sys_nice` so the audio threads can
  # run with realtime priority; the store is read-only, so use a wrapper.
  security.wrappers.audirvana-studio = {
    source = lib.getExe package;
    capabilities = "cap_sys_nice+ep";
    owner = "root";
    group = "root";
  };

  systemd.user.services.audirvana-studio = {
    description = "Audirvāna Studio";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      # %E is $XDG_CONFIG_HOME (~/.config), where Audirvāna reads it from.
      ExecStartPre = "${pkgs.coreutils}/bin/install -Dm644 ${adminConfig} %E/audirvana/adminconfig.json";
      ExecStart = "${config.security.wrapperDir}/audirvana-studio";
      Restart = "on-failure";
    };
  };

  # The Remote app finds the server over mDNS. publish.userServices lets a
  # non-root program advertise itself; avahi opens UDP 5353 in the firewall.
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
