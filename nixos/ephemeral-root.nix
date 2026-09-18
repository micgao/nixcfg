{
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=4G" "mode=755" ];
  };

  # zram swap, no swap partition needed
  zramSwap = {
    enable = true;
    memoryPercent = 50; # ~16GB compressed swap in RAM, on a 32GB system
    priority = 100;
  };
}
