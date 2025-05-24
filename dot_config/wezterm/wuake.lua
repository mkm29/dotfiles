-- ~/.config/wezterm/wuake.lua
local wuake = require("wuake_plugin")

return function(config)
    wuake.setup {
        config = config,
        -- Optional: customize here
        margin_bottom = 10,
        width_factor = 1,
        height_factor = 0.5,
        domain = "wuake",
        config_overrides = {}
    }
end
