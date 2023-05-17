local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.set_environment_variables = {
  TERMINFO_DIRS = "/home/micgao/.nix-profile/share/terminfo"
}
config.term = "wezterm"
config.color_scheme = "Sequoia Moonlight"
config.audible_bell = "Disabled"
config.bold_brightens_ansi_colors = "BrightAndBold"
config.enable_wayland = true
config.enable_tab_bar = false
config.front_end = "WebGpu"
config.check_for_updates = false
config.window_decorations = "NONE"
config.cursor_thickness = 2
config.cursor_blink_rate = 0
config.default_cursor_style = "SteadyBar"
config.adjust_window_size_when_changing_font_size = false

return config

