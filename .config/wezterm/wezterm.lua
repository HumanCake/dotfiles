-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()
-- Look and feel
config.font = wezterm.font("JetBrains Mono")
config.color_scheme = "Darcula (base16)"
config.enable_tab_bar = false

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
