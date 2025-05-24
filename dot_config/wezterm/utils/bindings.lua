-- ~/.config/wezterm/bindings.lua
local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

return function(config)
  config.mouse_bindings = {
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = act.CompleteSelection 'ClipboardAndPrimarySelection',
    },
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
    },
  }

    for _, key in ipairs({
    { key = "H", mods = "ALT|SHIFT", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "V", mods = "ALT|SHIFT", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = "W", mods = "ALT|SHIFT", action = act.CloseCurrentPane { confirm = false } },
    { key = "LeftArrow", mods = "CTRL", action = act.ActivatePaneDirection "Left" },
    { key = "RightArrow", mods = "CTRL", action = act.ActivatePaneDirection "Right" },
    { key = "UpArrow", mods = "CTRL", action = act.ActivatePaneDirection "Up" },
    { key = "DownArrow", mods = "CTRL", action = act.ActivatePaneDirection "Down" },
    { key = "t", mods = "CTRL|SHIFT", action = act.SpawnTab "CurrentPaneDomain" },
    { key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
    { key = "Tab", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
    { key = "&", mods = "CTRL|SHIFT", action = act.CloseCurrentTab { confirm = true } },

          key = ",", mods = "CTRL", action = act.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback(function(window, pane, line)
          if line then window:active_tab():set_title(line) end
        end),
      },
            key = "a",
      mods = "CTRL|SHIFT",
      action = act.AttachDomain 'unix',
          key = "d",
      mods = "CTRL|SHIFT",
      action = act.DetachDomain { DomainName = 'unix' },
          key = "$",
      mods = "CTRL|SHIFT",
      action = act.PromptInputLine {
        description = 'Enter new name for session',
        action = wezterm.action_callback(function(window, pane, line)
          if line then mux.rename_workspace(window:mux_window():get_workspace(), line) end
        end),
      },
          key = 's',
      mods = 'CTRL|SHIFT',
      action = act.ShowLauncherArgs { flags = 'WORKSPACES' },
        table.insert(config.keys, key)
      -- ~/.config/wezterm/options.lua
return function(config)
  config.tab_bar_at_bottom = false
  config.term = "xterm-256color"
  config.pane_focus_follows_mouse = true
  config.scrollback_lines = 10000
  config.initial_cols = 120
  config.initial_rows = 30
  config.hide_tab_bar_if_only_one_tab = true
  config.enable_tab_bar = true
  config.window_close_confirmation = "NeverPrompt"
  config.default_prog = { '/bin/zsh', '-l' }
  config.default_cursor_style = "BlinkingBar"
  config.automatically_reload_config = true
  config.hyperlink_rules = {
    {
      regex = "\\b\\w+://[\\w.-]+\\S*\\b",
      format = "$0",
    },
  }
  config.switch_to_last_active_tab_when_closing_tab = true
  config.audible_bell = "Disabled"
  config.visual_bell = {
    fade_in_duration_ms = 150,
    fade_out_duration_ms = 150,
    target = 'CursorColor',
  }
  config.front_end = "OpenGL"
  config.webgpu_power_preference = "HighPerformance"
  config.enable_wayland = false
  config.native_macos_fullscreen_mode = false
  config.enable_scroll_bar = true
  config.min_scroll_bar_height = "3cell"
  config.unix_domains = {
    {
      name = 'unix',
    },
  }
end