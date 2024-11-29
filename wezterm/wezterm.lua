local wezterm = require("wezterm")

local config = wezterm.config_builder()

config = {
    font = wezterm.font({
        family = "DejaVuSansM Nerd Font Mono",
        -- harfbuzz_features = { "calt=0" }, -- this disables ligatures
    }),
    font_size = 16,
    color_scheme = "Nancy (terminal.sexy)",
    enable_tab_bar = false,
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
    native_macos_fullscreen_mode = true,
}

return config
