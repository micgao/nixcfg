local wezterm = require "wezterm"
local act = wezterm.action

local config = {}

local gpus = wezterm.gui.enumerate_gpus()

if wezterm.config_builder then
  config = wezterm.config_builder()
end

wezterm.on('update-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)

config.keys = {
  {
    key = 'N',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.PromptInputLine {
      description = wezterm.format {
        { Text = 'Workspace name' },
      },
      action = wezterm.action_callback(function(window, pane, name)
        if name then
          window:perform_action(
            wezterm.action.SwitchToWorkspace {
              name = name,
            },
            pane
          )
        end
      end),
    },
  },
  {
    key = 'E',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ShowLauncherArgs {
      flags = 'FUZZY|WORKSPACES',
    },
  },
  {
    key = 'P',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ShowLauncherArgs { flags = 'TABS|LAUNCH_MENU_ITEMS|DOMAINS|WORKSPACES' },
  },
  {
    key = 'T',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ShowTabNavigator
  },
  {
    key = 't',
    mods = 'CTRL',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'H',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitPane {
      direction = 'Left',
    },
  },
  {
    key = 'J',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitPane {
      direction = 'Down',
    },
  },
  {
    key = 'K',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitPane {
      direction = 'Up',
    },
  },
  {
    key = 'L',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitPane {
      direction = 'Right',
    },
  },
  {
    key = 'h',
    mods = 'CTRL',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'j',
    mods = 'CTRL',
    action = act.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'CTRL',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'l',
    mods = 'CTRL',
    action = act.ActivatePaneDirection 'Right',
  },
}

config.set_environment_variables = {
  TERMINFO_DIRS = "/home/micgao/.nix-profile/share/terminfo"
}

config.term = "wezterm"
config.enable_kitty_keyboard = true
config.color_scheme = "Sequoia Moonlight"
config.colors = {
  tab_bar = {
    background = '#0F1014',
    active_tab = {
      bg_color = '#0F1014',
      fg_color = '#8EB5F5',
    },
    inactive_tab = {
      bg_color = '#0F1014',
      fg_color = '#9898A6',
    },
  },
  compose_cursor = '#FFBB88',
}
config.font = wezterm.font_with_fallback {
  {
    family = "Iosevka Fixed SS04 Extended",
  },
  {
    family = "Symbols Nerd Font Mono",
  },
}
config.font_size = 11.5
config.freetype_interpreter_version = 40
config.freetype_load_target = "Light"
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
config.custom_block_glyphs = false
config.use_cap_height_to_scale_fallback_fonts = true
config.warn_about_missing_glyphs = false
config.unicode_version = 14
config.cursor_thickness = 2
config.cursor_blink_rate = 0
config.default_cursor_style = "SteadyBar"
config.audible_bell = "Disabled"
config.bold_brightens_ansi_colors = "BrightAndBold"
config.scrollback_lines = 9001
config.enable_scroll_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.tab_and_split_indices_are_zero_based = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.enable_tab_bar = true
config.window_decorations = "NONE"
config.tiling_desktop_environments = {
  'X11 wlroots wm',
  'Wayland',
}
config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}
config.front_end = "WebGpu"
config.webgpu_preferred_adapter = gpus[1]
config.enable_wayland = false
config.check_for_updates = false

return config
