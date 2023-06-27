{
  programs.kitty = {
    enable = true;
    font = {
      name = "IntelOne Mono";
      size = 11.5;
    };
    settings = {
      scrollback_lines = 9001;
      enable_audio_bell = false;
      update_check_interval = 0;
      disable_ligatures = "always";
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
