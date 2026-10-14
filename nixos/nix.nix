{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      use-xdg-base-directories = true;
      trusted-users = [ "@wheel" ];
      build-dir = "/scratch/builds";
    };
    channel.enable = false;
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
  };
  # build-dir lives on the scratch drive, whose mount is nofail. Wants rather
  # than Requires, so a dead scratch drive still leaves Nix usable to fix it.
  systemd.services.nix-daemon.unitConfig.WantsMountsFor = [ "/scratch/builds" ];
}
