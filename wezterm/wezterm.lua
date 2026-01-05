---@type Wezterm
local wezterm = require("wezterm")

local config = wezterm.config_builder()

config = {
    font = wezterm.font({
        family = "CaskaydiaCove Nerd Font Mono",
    }),
    -- harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
    font_size = 16,
    color_scheme = "iTerm2 Tango Dark",
    enable_tab_bar = false,
    window_decorations = "RESIZE",
    initial_cols = 80,
    initial_rows = 25,
    cursor_thickness = 0,
}

return config
