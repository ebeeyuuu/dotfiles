local wezterm = require("wezterm")

local keybindings = {
  keys = {
    { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
    { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
  },
}

return keybindings
