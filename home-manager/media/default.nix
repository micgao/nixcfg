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
    package = pkgs.ncmpcpp.override { visualizerSupport = true; };
    bindings = [
      { key = "j"; command = "scroll_down"; }
      { key = "k"; command = "scroll_up"; }
      { key = "J"; command = [ "select_item" "scroll_down" ]; }
      { key = "K"; command = [ "select_item" "scroll_up" ]; }
    ];
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
