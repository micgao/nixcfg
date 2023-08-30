{ pkgs, ... }: {

  home = {
    packages = with pkgs; [
      mpdscribble
    ];
  };
  
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
    package = pkgs.ncmpcpp.override {
      visualizerSupport = true;
      clockSupport = true;
      taglibSupport = true;
    };
    bindings = [
      { key = "j"; command = "scroll_down"; }
      { key = "k"; command = "scroll_up"; }
      { key = "J"; command = [ "select_item" "scroll_down" ]; }
      { key = "K"; command = [ "select_item" "scroll_up" ]; }
      { key = "h"; command = "previous_column"; }
      { key = "l"; command = "next_column"; }
      { key = "L"; command = "show_lyrics"; }
      { key = "f1"; command = "toggle_lyrics_fetcher"; }
      { key = "down"; command = "volume_down"; }
      { key = "up"; command = "volume_up"; }
      { key = "space"; command = "pause"; }
      { key = "space"; command = "play"; }
    ];
    settings = {
      ncmpcpp_directory = "~/.ncmpcpp";
      lyrics_directory = "~/.ncmpcpp/lyrics";
      autocenter_mode = "yes";
      centered_cursor = "yes";
      playlist_display_mode = "columns";
      startup_screen = "media_library";
      media_library_primary_tag = "album_artist";
      colors_enabled = "yes";
      user_interface = "alternative";
      volume_color = "white";
      progressbar_look = "▂▂▂";
      progressbar_color = "black";
      progressbar_elapsed_color = "yellow";
      default_place_to_search_in = "database";
      follow_now_playing_lyrics = "yes";
      display_bitrate = "yes";
      display_remaining_time = "yes";
      cyclic_scrolling = "yes";
      jump_to_now_playing_song_at_start = "yes";
      regular_expressions = "extended";
      external_editor = "nvim";
      use_console_editor = "yes";
    };
  };
  programs.mpv = {
    enable = true;
    defaultProfiles = ["gpu-hq"];
    scripts = with pkgs.mpvScripts; [mpris thumbnail sponsorblock];
  };
  programs.ncspot = {
    enable = true;
    settings = {
      initial_screen = "library";
      use_nerdfont = true;
      default_keybindings = true;
    };
  };
  xdg.configFile."mpd/mpd.conf".source = ./mpd.conf;
  xdg.configFile."mpv/mpv.conf".source = ./mpv.conf;
}
