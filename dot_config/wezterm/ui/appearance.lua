local wezterm = require 'wezterm'

return function(config)
    -- Font and text settings
    config.font = wezterm.font_with_fallback({
        "JetBrainsMono Nerd Font", "FiraCode Nerd Font", "Noto Color Emoji"
    })
    config.font_size = 12.0
    config.color_scheme = "cyberpunk"

    -- Window appearance
    config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
    config.window_background_opacity = 0.9
    config.macos_window_background_blur = 10
    config.window_padding = {left = 20, right = 20, top = 10, bottom = 10}

    -- Tab bar appearance
    config.use_fancy_tab_bar = false
    config.show_tab_index_in_tab_bar = true
    config.tab_max_width = 32
    config.colors = {
        tab_bar = {
            background = "#1c1c1c",
            active_tab = {
                bg_color = "#FFFF00",
                fg_color = "#073642",
                intensity = "Bold"
            },
            inactive_tab = {bg_color = "#3c3c3c", fg_color = "#808080"},
            inactive_tab_hover = {bg_color = "#5c5c5c", fg_color = "#d0d0d0"},
            new_tab = {bg_color = "#2e2e2e", fg_color = "#808080"},
            new_tab_hover = {bg_color = "#5e5e5e", fg_color = "#d0d0d0"}
        }
    }

    -- Inactive pane style
    config.inactive_pane_hsb = {saturation = 0.9, brightness = 0.8}
end
