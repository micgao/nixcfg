{ pkgs, ... }: {
  programs = {
    steam = {
      enable = true;
      extraPackages = with pkgs; [
        gamescope
        mangohud
      ];
    };
    gamescope = {
      enable = true;
      enableWsi = true;
      capSysNice = true;
    };
  };
}
