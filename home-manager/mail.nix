{ pkgs, ... }: {
  programs = {
    mbsync.enable = true;
    mu.enable = true;
    msmtp.enable = true;
    himalaya.enable = true;
  };
}
