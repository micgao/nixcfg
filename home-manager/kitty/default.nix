{
  programs.kitty = {
    enable = true;
    font = {
      name = "Iosevka Term SS04 Extended";
      size = 11;
    };
    settings = {
      background_opacity = "0.9";
      scrollback_lines = 9001;
      enable_audio_bell = false;
      update_check_interval = 0;
      cursor_shape = "beam";
      copy_on_select = "clipboard";
      tab_bar_style = "separator";
    };
    shellIntegration = {
      enableZshIntegration = true;
    };
    theme = "Doom Vibrant";
  };
}
