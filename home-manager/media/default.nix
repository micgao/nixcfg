{ pkgs, config, ... }: {
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
    network.startWhenNeeded = true;
  };
  services.mpd-mpris = {
    enable = true;
    mpd.useLocal = true;
  };
  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-mpd
      mopidy-tidal
      mopidy-mpris
      mopidy-local
      mopidy-notify
      mopidy-youtube
      mopidy-spotify
      mopidy-podcast
      mopidy-scrobbler
    ];
  };
  programs.ncmpcpp = {
    enable = true;
  };
  programs.mpv = {
    enable = true;
  };
  programs.ncspot = {
    enable = true;
  };
  xdg.configFile."mpd/mpd.conf".source = ./mpd.conf;
  xdg.configFile."mpv/mpv.conf".source = ./mpv.conf;
}
