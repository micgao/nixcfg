{
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=4G" "mode=755" ];
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
    priority = 100;
  };
}
