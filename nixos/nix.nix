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
  };
  # dead scratch drive leaves Nix usable to fix it.
  systemd.services.nix-daemon.unitConfig.WantsMountsFor = [ "/scratch/builds" ];
}
