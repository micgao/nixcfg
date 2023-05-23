{ config, ... }: {
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
  };
  programs.ncmpcpp = {
    enable = true;
  };
  xdg.configFile."mpd/mpd.conf".source = ./mpd.conf;
}
