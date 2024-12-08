local wezterm = require("wezterm")

local config = wezterm.config_builder()

local general = require("general")
local appearance = require("appearance")
local keybindings = require("keybindings")

for k, v in pairs(general) do
  config[k] = v
end

for k, v in pairs(appearance) do
  config[k] = v
end

for k, v in pairs(keybindings) do
  config[k] = v
end

return config
