-- ~/.config/wezterm/utils/resurrect.lua
local wezterm = require 'wezterm'
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

return function(config)
  resurrect.set_encryption({
    enable = true,
    method = "age",
    private_key = "~/.age-key.txt",
    public_key = "age1e5nsrtaq8hygj2sc27e0hm44s4zkh02z97xyt9h9u5l7upr9scdq5043uu",
  })

  local listeners = {
    "resurrect.error",
    "resurrect.save_state.finished",
  }

  local is_periodic_save = false

  wezterm.on("resurrect.periodic_save", function()
    is_periodic_save = true
  end)

  for _, event in ipairs(listeners) do
    wezterm.on(event, function(...)
      if event == "resurrect.save_state.finished" and is_periodic_save then
        is_periodic_save = false
        return
      end
      local args = { ... }
      local msg = event
      for _, v in ipairs(args) do
        msg = msg .. " " .. tostring(v)
      end
      wezterm.gui.gui_windows()[1]:toast_notification("Wezterm - resurrect", msg, nil, 4000)
    end)
  end

  wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
    resurrect.workspace_state.restore_workspace(resurrect.load_state(label, "workspace"), {
      window = window,
      relative = true,
      restore_text = true,
      on_pane_restore = resurrect.tab_state.default_on_pane_restore,
    })
  end)

  wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
    resurrect.save_state(resurrect.workspace_state.get_workspace_state())
  end)

  config.keys = config.keys or {}

  for _, keymap in ipairs({
    {
      key = "w",
      mods = "ALT",
      action = wezterm.action_callback(function(win, pane)
        resurrect.save_state(resurrect.workspace_state.get_workspace_state())
      end),
    },
    {
      key = "W",
      mods = "ALT",
      action = resurrect.window_state.save_window_action(),
    },
    {
      key = "T",
      mods = "ALT",
      action = resurrect.tab_state.save_tab_action(),
    },
    {
      key = "s",
      mods = "ALT",
      action = wezterm.action_callback(function(win, pane)
        resurrect.save_state(resurrect.workspace_state.get_workspace_state())
        resurrect.window_state.save_window_action()
      end),
    },
    {
      key = "r",
      mods = "ALT",
      action = wezterm.action_callback(function(win, pane)
        resurrect.fuzzy_load(win, pane, function(id, label)
          local type = string.match(id, "^([^/]+)")
          id = string.match(id, "([^/]+)$")
          id = string.match(id, "(.+)%..+$")
          local opts = {
            relative = true,
            restore_text = true,
            on_pane_restore = resurrect.tab_state.default_on_pane_restore,
          }
          if type == "workspace" then
            resurrect.workspace_state.restore_workspace(resurrect.load_state(id, "workspace"), opts)
          elseif type == "window" then
            resurrect.window_state.restore_window(pane:window(), resurrect.load_state(id, "window"), opts)
          elseif type == "tab" then
            resurrect.tab_state.restore_tab(pane:tab(), resurrect.load_state(id, "tab"), opts)
          end
        end)
      end),
    },
  }) do
    table.insert(config.keys, keymap)
  end
end

-- ~/.config/wezterm/ui/tabline.lua
local wezterm = require 'wezterm'
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

return function(config)
  tabline.setup({
    options = {
      icons_enabled = true,
      theme = 'cyberpunk',
      color_overrides = {},
      section_separators = {
        left = wezterm.nerdfonts.pl_left_hard_divider,
        right = wezterm.nerdfonts.pl_right_hard_divider,
      },
      component_separators = {
        left = wezterm.nerdfonts.pl_left_soft_divider,
        right = wezterm.nerdfonts.pl_right_soft_divider,
      },
      tab_separators = {
        left = wezterm.nerdfonts.pl_left_hard_divider,
        right = wezterm.nerdfonts.pl_right_hard_divider,
      },
    },
    sections = {
      tabline_a = { 'mode' },
      tabline_b = { 'workspace' },
      tabline_c = { ' ' },
      tab_active = {
        'index',
        { 'parent', padding = 0 },
        '/',
        { 'cwd', padding = { left = 0, right = 1 } },
        { 'zoomed', padding = 0 },
      },
      tab_inactive = { 'index', { 'process', padding = { left = 0, right = 1 } } },
      tabline_x = { 'ram', 'cpu' },
      tabline_y = { 'datetime', 'battery' },
      tabline_z = { 'hostname' },
    },
    extensions = {},
  })
end