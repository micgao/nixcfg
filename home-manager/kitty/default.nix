{
  programs.kitty = {
    enable = true;
    font = {
      name = "Iosevka SS04";
      size = 11;
    };
    settings = {
      cursor = "none";
      scrollback_lines = 9001;
      scrollback_pager_history_size = 2048;
      disable_ligatures = "always";
      undercurl_style = "thin-sparse";
      enable_audio_bell = false;
      visual_bell_duration = 0;
      update_check_interval = 0;
      hide_window_decorations = "yes";
      cursor_shape = "beam";
      cursor_beam_thickness = 2;
      cursor_blink_interval = 0;
      mouse_hide_wait = -1;
      copy_on_select = "clipboard";
      enabled_layouts = "all";
      tab_bar_edge = "bottom";
      tab_bar_margin_width = 0;
      tab_bar_min_tabs = 1;
      tab_title_max_length = 16;
      tab_title_template = " {index}: {title}{activity_symbol} ";
      tab_bar_style = "separator";
      tab_separator = " | ";
      selection_foreground = "none";
      selection_background = "none";
      draw_minimal_borders = "yes";
      strip_trailing_spaces = "smart";
      linux_display_server = "wayland";
    };
    shellIntegration = {
      enableZshIntegration = true;
    };
  };
}
