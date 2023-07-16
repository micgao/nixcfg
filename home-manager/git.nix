{ pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = "Michael G";
      userEmail = "micgao@pm.me";
      delta = {
        enable = true;
      };
    };
    gitui.enable = true;
    git-credential-oauth.enable = true;
  };
}
