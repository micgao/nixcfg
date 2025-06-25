local wezterm = require "wezterm"

local config = {}

local gpus = wezterm.gui.enumerate_gpus()

if wezterm.config_builder then
  config = wezterm.config_builder()
end

wezterm.on('update-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  {
    key = 'n',
    mods = 'CTRL|LEADER',
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
    key = 'p',
    mods = 'CTRL|LEADER',
    action = wezterm.action.ShowLauncherArgs { flags = 'TABS|LAUNCH_MENU_ITEMS|DOMAINS|WORKSPACES' },
  },
  {
    key = 'e',
    mods = 'CTRL|LEADER',
    action = wezterm.action.ShowTabNavigator
  },
  {
    key = 't',
    mods = 'CTRL|LEADER',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'H',
    mods = 'CTRL|SHIFT|LEADER',
    action = wezterm.action.SplitPane {
      direction = 'Left',
    },
  },
  {
    key = 'J',
    mods = 'CTRL|SHIFT|LEADER',
    action = wezterm.action.SplitPane {
      direction = 'Down',
    },
  },
  {
    key = 'K',
    mods = 'CTRL|SHIFT|LEADER',
    action = wezterm.action.SplitPane {
      direction = 'Up',
    },
  },
  {
    key = 'L',
    mods = 'CTRL|SHIFT|LEADER',
    action = wezterm.action.SplitPane {
      direction = 'Right',
    },
  },
  {
    key = 'h',
    mods = 'CTRL|LEADER',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'j',
    mods = 'CTRL|LEADER',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'CTRL|LEADER',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'l',
    mods = 'CTRL|LEADER',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
}

config.set_environment_variables = {
  TERMINFO_DIRS = "/home/micgao/.nix-profile/share/terminfo"
}

config.term = "wezterm"
config.enable_kitty_keyboard = true
config.max_fps = 144
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
    family = "Iosevka SS04",
  },
}
config.font_size = 11
config.adjust_window_size_when_changing_font_size = false
config.freetype_interpreter_version = 40
config.freetype_load_target = "HorizontalLcd"
config.freetype_render_target = "Light"
config.freetype_load_flags = "NO_HINTING"
config.harfbuzz_features = { 'calt = 0', 'clig = 0', 'liga = 0' }
config.unicode_version = 14
config.allow_square_glyphs_to_overflow_width = "Never"
config.cursor_thickness = 2
config.cursor_blink_rate = 0
config.default_cursor_style = "SteadyBar"
config.audible_bell = "Disabled"
config.bold_brightens_ansi_colors = "BrightAndBold"
config.scrollback_lines = 9001
config.enable_scroll_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.tab_and_split_indices_are_zero_based = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.enable_tab_bar = true
config.front_end = "WebGpu"
config.webgpu_preferred_adapter = gpus[1]
config.enable_wayland = true
config.check_for_updates = false
config.command_palette_bg_color = "#0F1014"
config.command_palette_fg_color = "#8EB5F5"
config.command_palette_font_size = 12
config.unix_domains = {
  {
    name = 'unix',
  },
}
return config
