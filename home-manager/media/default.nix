{ config, ... }: {
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
    network.startWhenNeeded = true;
  };
  programs.ncmpcpp = {
    enable = true;
  };
  programs.mpv = {
    enable = true;
  };
  xdg.configFile."mpd/mpd.conf".source = ./mpd.conf;
  xdg.configFile."mpv/mpv.conf".source = ./mpv.conf;
}
