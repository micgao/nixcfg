{ pkgs, ... }: {
  programs = {
    mbsync.enable = true;
    mu.enable = true;
    # msmtp.enable = true;
  };
  services = {
    mbsync = {
      enable = true;
      preExec = "${pkgs.isync}/bin/mbsync -Ha";
      postExec = "${pkgs.mu}/bin/mu index";
    };
  };
}
