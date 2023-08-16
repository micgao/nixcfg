local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "Sequoia Moonlight"
config.font = wezterm.font_with_fallback {
  {
    family = "Iosevka Fixed SS04 Extended",
  },
  {
    family = "Symbols Nerd Font",
  },
}
config.font_size = 11.5
config.scrollback_lines = 9001
config.enable_scroll_bar = false
config.front_end = "WebGpu"
config.audible_bell = "Disabled"
config.bold_brightens_ansi_colors = "BrightAndBold"
config.enable_wayland = false
config.enable_tab_bar = false
config.check_for_updates = false
config.cursor_thickness = 2
config.cursor_blink_rate = 0
config.max_fps = 145
config.default_cursor_style = "SteadyBar"
config.adjust_window_size_when_changing_font_size = false
config.window_padding = {
  left = 4,
  right = 4,
  top = 4,
  bottom = 4,
}

return config
