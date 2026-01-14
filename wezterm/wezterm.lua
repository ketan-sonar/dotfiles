---@type Wezterm
local wezterm = require("wezterm")

local config = wezterm.config_builder()

config = {
    font = wezterm.font({
        family = "IosevkaTerm Nerd Font Mono",
    }),
    -- harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
    font_size = 18,
    color_scheme = "catppuccin-mocha",
    colors = { background = "#101019" },
    enable_tab_bar = false,
    window_decorations = "RESIZE",
    initial_cols = 100,
    initial_rows = 25,
    cursor_thickness = 0,
}

return config
