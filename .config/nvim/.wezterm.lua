local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("CaskaydiaCove Nerd Font")

config.default_cursor_style = "SteadyBar"

config.window_background_image = "/Users/eanyu/.warp/themes/precious.jpg"
config.window_background_image_hsb = {
  brightness = 0.05,
  hue = 1,
  saturation = 1,
}

config.window_decorations = "RESIZE";

config.window_background_opacity = 0.8
config.macos_window_background_blur = 40

config.colors = {
  cursor_bg = "#c2c2c2",
  cursor_fg = "#c2c2c2",
  cursor_border = "#c2c2c2",
  tab_bar = {
    background = "#000000",
    active_tab = {
      bg_color = "#1a1a1a",
      fg_color = "#c0c0c0",
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#000000",
      fg_color = "#909090",
      intensity = "Normal",
    },
    inactive_tab_hover = {
      bg_color = "#222222",
      fg_color = "#c0c0c0",
    },
    new_tab_hover = {
      bg_color = "#222222",
      fg_color = "#c0c0c0",
    }
  },
}

config.window_frame = {
  font = wezterm.font("CaskaydiaCove Nerd Font"),
  font_size = 15.0,
  active_titlebar_bg = '#000000',
  inactive_titlebar_bg = '#000000',
}

config.window_padding = {
  top = 10,
  right = 10,
  bottom = 0,
  left = 10,
}

return config
