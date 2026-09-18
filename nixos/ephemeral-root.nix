{
  # Root filesystem lives entirely in RAM and starts blank on every boot.
  # Everything NOT separately mounted (via disko: /boot, /nix, /home,
  # /var/log, /root) is ephemeral, including /etc's writable overlay layer
  # (system.etc.overlay.enable's upperdir/workdir live at /.rw-etc, which
  # sits on "/" -- so /etc resets on reboot too, with no extra config).
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=4G" "mode=755" ];
  };

  # zram-backed swap instead of a disk-based swap partition.
  zramSwap = {
    enable = true;
    memoryPercent = 50; # ~16GB compressed swap in RAM, on a 32GB system
    priority = 100;
  };
}
