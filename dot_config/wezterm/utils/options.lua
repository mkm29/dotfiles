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
    config.default_prog = {'/bin/zsh', '-l'}
    config.default_cursor_style = "BlinkingBar"
    config.automatically_reload_config = true
    config.hyperlink_rules = {
        {regex = "\\b\\w+://[\\w.-]+\\S*\\b", format = "$0"}
    }
    config.switch_to_last_active_tab_when_closing_tab = true
    config.audible_bell = "Disabled"
    config.visual_bell = {
        fade_in_duration_ms = 150,
        fade_out_duration_ms = 150,
        target = 'CursorColor'
    }
    config.front_end = "OpenGL"
    config.webgpu_power_preference = "HighPerformance"
    config.enable_wayland = false
    config.native_macos_fullscreen_mode = false
    config.enable_scroll_bar = true
    config.min_scroll_bar_height = "3cell"
    config.unix_domains = {{name = 'unix'}}
end
