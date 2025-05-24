local wezterm = require("wezterm")
local resurrect = wezterm.plugin.require(
                      "https://github.com/MLFlexer/resurrect.wezterm")
local mux = wezterm.mux

local resurrect_event_listeners = {
    "resurrect.error", "resurrect.save_state.finished"
}
local is_periodic_save = false

wezterm.on("resurrect.periodic_save", function() is_periodic_save = true end)
for _, event in ipairs(resurrect_event_listeners) do
    wezterm.on(event, function(...)
        if event == "resurrect.save_state.finished" and is_periodic_save then
            is_periodic_save = false
            return
        end
        local args = {...}
        local msg = event
        for _, v in ipairs(args) do msg = msg .. " " .. tostring(v) end
        wezterm.gui.gui_windows()[1]:toast_notification("Wezterm - resurrect",
                                                        msg, nil, 4000)
    end)
end

wezterm.on("smart_workspace_switcher.workspace_switcher.created",
           function(window, path, label)
    local workspace_state = resurrect.workspace_state

    workspace_state.restore_workspace(resurrect.load_state(label, "workspace"),
                                      {
        window = window,
        relative = true,
        restore_text = true,
        on_pane_restore = resurrect.tab_state.default_on_pane_restore
    })
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.selected",
           function(window, path, label)
    local workspace_state = resurrect.workspace_state
    resurrect.save_state(workspace_state.get_workspace_state())
end)

return resurrect
