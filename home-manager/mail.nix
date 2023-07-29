{ pkgs, ... }: {
  programs = {
    mbsync.enable = true;
    mu.enable = true;
    msmtp = {
      enable = true;
    };
  };
  services = {
    mbsync.enable = true;
  };
}
