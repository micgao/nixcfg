{ config, ... }:
let
  inherit (config.colorscheme) palette;
in
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
      tab_bar_style = "separator";
      tab_activity_symbol = " *";
      tab_bar_min_tabs = 1;
      tab_title_max_length = 16;
      tab_title_template = "{index}: {title}{activity_symbol}";
      inactive_tab_background = "#${palette.base00}";
      inactive_tab_foreground = "#${palette.base05}";
      active_tab_background = "#${palette.base01}";
      active_tab_foreground = "#${palette.base06}";
      tab_bar_background = "#${palette.base00}";
      foreground = "#${palette.base06}";
      background = "#${palette.base00}";
      selection_foreground = "none";
      selection_background = "none";
      draw_minimal_borders = "yes";
      strip_trailing_spaces = "smart";
      linux_display_server = "wayland";
      color0 = "#${palette.base00}";
      color1 = "#${palette.base08}";
      color2 = "#${palette.base0B}";
      color3 = "#${palette.base0A}";
      color4 = "#${palette.base0D}";
      color5 = "#${palette.base0E}";
      color6 = "#${palette.base0C}";
      color7 = "#${palette.base05}";
      color8 = "#${palette.base03}";
      color9 = "#${palette.base08}";
      color10 = "#${palette.base0B}";
      color11 = "#${palette.base0A}";
      color12 = "#${palette.base0D}";
      color13 = "#${palette.base0E}";
      color14 = "#${palette.base0C}";
      color15 = "#${palette.base07}";
      color16 = "#${palette.base09}";
      color17 = "#${palette.base0F}";
      color18 = "#${palette.base01}";
      color19 = "#${palette.base02}";
      color20 = "#${palette.base04}";
      color21 = "#${palette.base06}";
    };
    shellIntegration = {
      enableZshIntegration = true;
    };
  };
}
