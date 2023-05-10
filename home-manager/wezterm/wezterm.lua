local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "Sequoia Moonlight"
config.audible_bell = "Disabled"
config.bold_brightens_ansi_colors = "BrightAndBold"
config.enable_wayland = true
config.enable_tab_bar = false
config.front_end = "WebGpu"
config.check_for_updates = false
config.cursor_thickness = 0.3
config.default_cursor_style = "SteadyBar"

return config

