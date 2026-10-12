{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      use-xdg-base-directories = true;
      trusted-users = [ "@wheel" ];
      build-dir = "/nix/var/nix/builds";
    };
    channel.enable = false;
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
  };
  systemd.tmpfiles.rules = [ "d /nix/var/nix/builds 0755 root root -" ];
}
