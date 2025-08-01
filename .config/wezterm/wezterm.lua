-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- enable wezterm to work in virtualbox windows
config.prefer_egl = true

-- fix alt on mac
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

-- Look and feel
config.font = wezterm.font("JetBrains Mono")
config.color_scheme = "Dracula (Official)"
config.enable_tab_bar = false

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
-- Keybinds
config.leader = {
	key = " ",
	mods = "ALT",
	timeout_milliseconds = 1000,
}

local resize_amount = 20
config.keys = {
	-- Pane navigation (after Alt+a)
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	-- Pane resizing (LEADER + SHIFT + hjkl)
	{
		key = "H", -- Shift+h
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Left", resize_amount }),
	},
	{
		key = "J", -- Shift+j
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Down", resize_amount }),
	},
	{
		key = "K", -- Shift+k
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Up", resize_amount }),
	},
	{
		key = "L", -- Shift+l
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Right", resize_amount }),
	},

	-- Split panes (after Alt+a)
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Close panes
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
}

return config
