local wezterm = require 'wezterm'
local config = wezterm.config_builder and wezterm.config_builder() or {}

-- config.unix_domains = config.unix_domains or {}
-- table.insert(config.unix_domains, {name = "wuake", multiplexing = "Mux"})

for _, module in ipairs({
    "utils.resurrect", "ui.tabline", "ui.appearance", "utils.bindings",
    "utils.options" -- "wuake" -- <- add here
}) do
    local ok, mod = pcall(require, module)
    if ok and type(mod) == "function" then mod(config) end
end

return config
