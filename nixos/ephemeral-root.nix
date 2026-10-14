{
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=4G" "mode=755" ];
  };

  # Mount /persist in the initrd so it is already there when the real system
  # starts. Without this, userborn (which reads/writes /persist/userborn) can
  # run before the stage-2 mount and write into the tmpfs underneath it.
  fileSystems."/persist".neededForBoot = true;

  # Keep the same machine-id across boots without putting it in the repo.
  # systemd follows this symlink when reading /etc/machine-id, which works
  # because /persist is mounted before PID 1 looks (see neededForBoot above).
  # The target file must exist before switching to this config.
  environment.etc."machine-id" = {
    source = "/persist/etc/machine-id";
    mode = "direct-symlink";
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
    priority = 100;
  };
}
