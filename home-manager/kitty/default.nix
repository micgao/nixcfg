{ config, ... }: 
let
  inherit (config.colorscheme) colors;
in
{
  programs.kitty = {
    enable = true;
    font = {
      name = "Iosevka Fixed SS04 Extended";
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
      tab_bar_style = "separator";
      tab_activity_symbol = "●";
      tab_bar_min_tabs = 1;
      tab_title_max_length = 16;
      tab_title_template = "{index}:{title}{activity_symbol}";
      inactive_tab_background = "#${colors.base01}";
      inactive_tab_foreground = "#${colors.base05}";
      active_tab_background = "#${colors.base00}";
      active_tab_foreground = "#${colors.base06}";
      tab_bar_background = "#${colors.base01}";
      foreground = "#${colors.base06}";
      background = "#${colors.base00}";
      selection_foreground = "none";
      selection_background = "none";
      draw_minimal_borders = "yes";
      strip_trailing_spaces = "smart";
      linux_display_server = "wayland";
      color0 = "#${colors.base00}";
      color1 = "#${colors.base08}";
      color2 = "#${colors.base0B}";
      color3 = "#${colors.base0A}";
      color4 = "#${colors.base0D}";
      color5 = "#${colors.base0E}";
      color6 = "#${colors.base0C}";
      color7 = "#${colors.base05}";
      color8 = "#${colors.base03}";
      color9 = "#${colors.base08}";
      color10 = "#${colors.base0B}";
      color11 = "#${colors.base0A}";
      color12 = "#${colors.base0D}";
      color13 = "#${colors.base0E}";
      color14 = "#${colors.base0C}";
      color15 = "#${colors.base07}";
      color16 = "#${colors.base09}";
      color17 = "#${colors.base0F}";
      color18 = "#${colors.base01}";
      color19 = "#${colors.base02}";
      color20 = "#${colors.base04}";
      color21 = "#${colors.base06}";
    };
    shellIntegration = {
      enableZshIntegration = true;
    };
  };
}
