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

  # The target file must exist before switching to this config
  # (comment off the section on initial install)
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
