{ lib, ... }:

let
  persist = "/persist";

  # Directories bind-mounted from /persist onto the ephemeral root
  directories = [
    "/etc/NetworkManager/system-connections"
    "/var/lib/bluetooth"
    "/var/lib/iwd"
    "/var/lib/nixos"
    "/var/lib/systemd/coredump"
    "/var/lib/systemd/rfkill"
    "/var/lib/systemd/timers"
  ];

  # Files under /etc symlinked into /persist/etc
  etcFiles = [
    "machine-id"
  ];
in
{
  fileSystems = {
    ${persist}.neededForBoot = true;
  } // lib.genAttrs directories (dir: {
    device = "${persist}${dir}";
    fsType = "none";
    options = [ "bind" "x-gvfs-hide" ];
    depends = [ persist ];
  });

  # Create the bind sources in the initrd, after /persist is mounted at
  # /sysroot/persist and before the bind mounts run in stage 2
  boot.initrd.systemd.tmpfiles.settings.persist = lib.genAttrs
    (map (dir: "/sysroot${persist}${dir}") directories)
    (_: { d.mode = "0700"; });

  environment.etc = lib.genAttrs etcFiles (file: {
    source = "${persist}/etc/${file}";
  });
}
