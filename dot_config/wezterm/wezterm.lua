-- .config/wezterm/wezterm.lua
local wezterm = require("wezterm") --[[@as Wezterm]]
local mux = wezterm.mux
local act = wezterm.action

local scratch = "_scratch" -- Keep this consistent with Hammerspoon
wezterm.on("gui-attached", function(domain)
  local workspace = mux.get_active_workspace()
  if workspace ~= scratch then return end

  -- Compute width: 66% of screen width, up to 1000 px
  local width_ratio = 0.66
  local width_max = 1000
  local aspect_ratio = 16 / 9
  local screen = wezterm.gui.screens().active
  local width = math.min(screen.width * width_ratio, width_max) 
  local height = width / aspect_ratio

  for _, window in ipairs(mux.all_windows()) do
    local gwin = window:gui_window()
    if gwin ~= nil then
      gwin:perform_action(act.SetWindowLevel "AlwaysOnTop", gwin:active_pane())
      gwin:set_inner_size(width, height)
    end
  end
end)