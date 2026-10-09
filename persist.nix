{
  fileSystems."/persist".neededForBoot = true;

  preservation = {
    enable = true;
    preserveAt."/persist" = {
      directories = [
        "/etc/NetworkManager/system-connections"
        "/var/lib/bluetooth"
        "/var/lib/iwd"
        "/var/lib/systemd/coredump"
        "/var/lib/systemd/rfkill"
        "/var/lib/systemd/timers"
        { directory = "/var/lib/nixos"; inInitrd = true; }
      ];
      files = [
        { file = "/etc/machine-id"; inInitrd = true; how = "symlink"; configureParent = true; }
        { file = "/var/lib/systemd/random-seed"; how = "symlink"; inInitrd = true; configureParent = true; }
      ];
    };
  };

  # Commit the machine-id generated on first boot to /persist
  systemd.services.systemd-machine-id-commit = {
    unitConfig.ConditionPathIsMountPoint = [
      ""
      "/persist/etc/machine-id"
    ];
    serviceConfig.ExecStart = [
      ""
      "systemd-machine-id-setup --commit --root /persist"
    ];
  };
}
