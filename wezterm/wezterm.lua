local wezterm = require("wezterm")

local config = wezterm.config_builder()

config = {
  font = wezterm.font({
    family = "SauceCodePro Nerd Font Mono",
    -- harfbuzz_features = { "calt=0" }, -- this disables ligatures
  }),
  font_size = 16,
  -- color_scheme = "tokyonight_night",
  color_scheme = "Nancy (terminal.sexy)",
  enable_tab_bar = false,
  window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
  native_macos_fullscreen_mode = true,
  -- window_decorations = "RESIZE",
  -- window_background_opacity = 0.85,
  -- macos_window_background_blur = 15,
}

return config
