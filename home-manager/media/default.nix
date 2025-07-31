{ pkgs, config, ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    dataDir = "${config.home.homeDirectory}/.mpd";
    playlistDirectory = "${config.home.homeDirectory}/.mpd/playlists";
    network = {
      listenAddress = "127.0.0.1";
      port = 6600;
      startWhenNeeded = true;
    };
    extraConfig = ''
      auto_update "yes"
      follow_outside_symlinks "yes"
      follow_inside_symlinks "yes"
      input {
        plugin "simple"
      }
      input_cache {
        size "1 GB"
      }
      audio_output {
        type "pipewire"
        name "pipewire"
      }
      audio_output {
        type "fifo"
        name "fifo_visualizer"
        path "/tmp/mpd.fifo"
        format "44100:16:2"
      }
    '';
  };
  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override {
      visualizerSupport = true;
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
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "fifo_visualizer";
      visualizer_in_stereo = "yes";
      visualizer_look = "+|";
      mpd_crossfade_time = "0";
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
    defaultProfiles = [ "gpu-hq" ];
    config = {
      profile = "gpu-hq";
      ytdl-format = "bestvideo+bestaudio";
      user-agent = "Mozilla/5.0";
    };
  };
  programs.ncspot = {
    enable = true;
    settings = {
      initial_screen = "library";
      use_nerdfont = true;
      default_keybindings = true;
    };
  };
}
