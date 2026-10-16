{ config, lib, pkgs, ... }:
let
  rygelPort = 30802;
  # Renderer only: no media server plugins, so nothing gets exported or indexed.
  rygelConfig = pkgs.writeText "rygel.conf" ''
    [general]
    port=${toString rygelPort}
    enable-transcoding=false
    allow-upload=false
    allow-deletion=false

    [Playbin]
    enabled=true
    title=XDDD
  '';
  # Rygel loads every plugin in its plugin dir, and the bundled example server
  # plugins abort at startup (core-dump). Only expose the Playbin renderer.
  rygelPlugins = pkgs.runCommand "rygel-playbin-plugin" { } ''
    mkdir $out
    cp ${pkgs.rygel}/lib/rygel-*/plugins/{playbin.plugin,librygel-playbin.so} $out/
  '';
in
{
  # Local UPnP renderer for Audirvana. Plays through PipeWire so the DAC stays
  # shared with desktop audio instead of being locked exclusively.
  environment.systemPackages = [ pkgs.rygel ];

  systemd.user.services.rygel = {
    description = "Rygel UPnP renderer";
    after = [ "pipewire.service" ];
    wantedBy = [ "default.target" ];
    environment = {
      GST_PLUGIN_SYSTEM_PATH_1_0 = "${pkgs.pipewire}/lib/gstreamer-1.0";
      RYGEL_PLUGIN_PATH = rygelPlugins;
    };
    serviceConfig = {
      ExecStart = "${lib.getExe' pkgs.rygel "rygel"} --config ${rygelConfig}";
      Restart = "on-failure";
    };
  };

  # Rygel announces itself over SSDP (UDP 1900); avahi is already enabled by audirvana.nix.
  networking.firewall = {
    allowedTCPPorts = [ rygelPort ];
    allowedUDPPorts = [ 1900 ];
  };
}
