local wezterm = require "wezterm"
local act = wezterm.action

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

wezterm.on('update-right-status', function(window, pane)
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
    key = 'w',
    mods = 'CTRL',
    action = wezterm.action.CloseCurrentPane { confirm = true },
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

config.launch_menu = {
  {
    args = { 'zsh' },
  },
  {
    args = { 'nu' },
  },
  {
    args = { 'btm' },
  },
  {
    args = { 'procs' },
  },
  {
    args = { 'ncmpcpp' },
  },
  {
    args = { 'ncspot' },
  },
  {
    args = { 'newsboat' },
  },
  {
    args = { 'clx' },
  },
}

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
}
config.font = wezterm.font_with_fallback {
  {
    family = "Iosevka Fixed SS04 Extended",
  },
  {
    family = "Symbols Nerd Font",
  },
}
config.font_size = 11.5
config.custom_block_glyphs = false
config.unicode_version = 14
config.cursor_thickness = 2
config.cursor_blink_rate = 0
config.default_cursor_style = "SteadyBar"
config.webgpu_power_preference = "HighPerformance"
config.prefer_egl = true
config.audible_bell = "Disabled"
config.bold_brightens_ansi_colors = "BrightAndBold"
config.scrollback_lines = 9001
config.enable_scroll_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.tab_and_split_indices_are_zero_based = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
-- config.enable_tab_bar = false
config.window_decorations = "NONE"
config.tiling_desktop_environments = {
  'X11 wlroots wm',
  'Wayland',
}
config.window_padding = {
  left = 4,
  right = 4,
  top = 4,
  bottom = 4,
}
config.max_fps = 145
config.front_end = "WebGpu"
config.enable_wayland = false
config.check_for_updates = false

return config
