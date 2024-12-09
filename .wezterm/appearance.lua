local wezterm = require("wezterm")
local nf = wezterm.nerdfonts

local GLYPH_SCIRCLE_LEFT = nf.ple_lower_right_triangle
local GLYPH_SCIRCLE_RIGHT = nf.ple_lower_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local active_bg = "#000027"
  local active_fg = "#D1D9E6"
  local inactive_bg = "#000011"
  local inactive_fg = "#A3B2C8"
  local hover_bg = "#000023"
  local hover_fg = "#E4ECF5"

  local is_active = tab.is_active
  local background = is_active and active_bg or (hover and hover_bg or inactive_bg)
  local foreground = is_active and active_fg or (hover and hover_fg or inactive_fg)

  local triangle_color = is_active and "#000027" or "#000011"

  local title = tab.active_pane.title

  return {
    { Foreground = { Color = triangle_color } },
    { Background = { Color = "none" } },
    { Text = GLYPH_SCIRCLE_LEFT },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = " " .. title .. " " },
    { Foreground = { Color = triangle_color } },
    { Background = { Color = "none" } },
    { Text = GLYPH_SCIRCLE_RIGHT },
  }
end)

local appearance = {
  font_size = 18.0,
  window_background_opacity = 0.8,
  macos_window_background_blur = 40,
  window_decorations = "RESIZE",
  colors = {
    background = "#000000",
    cursor_bg = "#c2c2c2",
    cursor_fg = "#c2c2c2",
    cursor_border = "#c2c2c2",
    tab_bar = {
      background = "#1a1a1a",
      active_tab = {
        bg_color = "#002147",
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
      },
    },
  },
  enable_tab_bar = true,
  use_fancy_tab_bar = false,
  window_frame = {
    font = wezterm.font("CaskaydiaCove Nerd Font"),
    font_size = 18.0,
    active_titlebar_bg = '#000000',
    inactive_titlebar_bg = '#000000',
  },
  window_padding = {
    top = 10,
    right = 10,
    bottom = 0,
    left = 10,
  },
}

return appearance
