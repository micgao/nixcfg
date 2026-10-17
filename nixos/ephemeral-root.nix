{
  imports = [ ./persist.nix ];

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=4G" "mode=755" ];
  };

  # Mount /persist in the initrd so it is already there when the real system
  # starts. Without this, userborn (which reads/writes /persist/userborn) can
  # run before the stage-2 mount and write into the tmpfs underneath it.
  fileSystems."/persist".neededForBoot = true;

  # Everything outside /home is stateless except what is listed here.
  persist = {
    directories = [
      { path = "/var/log"; }
      { path = "/root"; mode = "0700"; }
      # Read directly by userborn (services.userborn.passwordFilesLocation),
      # keeping uid/gid allocation stable across boots.
      { path = "/userborn"; bind = false; }
    ];
    # "uninitialized" makes the first boot generate an ID and
    # systemd-machine-id-commit write it through the bind mount; afterwards
    # the persisted ID is used as-is. See machine-id(5), First Boot Semantics.
    files = [
      { path = "/etc/machine-id"; content = "uninitialized\n"; mode = "0444"; }
    ];
  };

  # Bind target in the /etc overlay. Mirrors what nixpkgs does for an
  # immutable overlay (nixos/modules/system/etc/etc-activation.nix).
  environment.etc.machine-id = {
    text = "";
    mode = "0444";
  };

  # Upstream only conditions this unit on /etc being writable, which would
  # re-run the commit every boot. As nixpkgs does for the immutable overlay,
  # only commit on first boot; the empty entry resets upstream conditions.
  systemd.services.systemd-machine-id-commit.unitConfig = {
    ConditionFirstBoot = [ "" "true" ];
    ConditionPathIsMountPoint = "/etc/machine-id";
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
    priority = 100;
  };
}
