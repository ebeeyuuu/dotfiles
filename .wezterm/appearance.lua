local wezterm = require("wezterm")
local mux = wezterm.mux
local nf = wezterm.nerdfonts

local left_arrow = nf.ple_lower_right_triangle
local right_arrow = nf.ple_lower_left_triangle

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local active_bg = "#13161d"
  local active_fg = "#D1D9E6"
  local inactive_bg = "#0c0e14"
  local inactive_fg = "#A3B2C8"
  local hover_bg = "#000023"
  local hover_fg = "#E4ECF5"

  local is_active = tab.is_active
  local background = is_active and active_bg or (hover and hover_bg or inactive_bg)
  local foreground = is_active and active_fg or (hover and hover_fg or inactive_fg)

  local triangle_color = is_active and "#13161d" or "#0c0e14"

  local title = tab.active_pane.title

  return {
    { Foreground = { Color = triangle_color } },
    { Background = { Color = "#000000" } },
    { Text = left_arrow },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = " " .. title .. " " },
    { Foreground = { Color = triangle_color } },
    { Background = { Color = "#000000" } },
    { Text = right_arrow },
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
      background = "#000000",
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
      new_tab = {
        bg_color = "#000000",
        fg_color = "#c0c0c0",
      },
      new_tab_hover = {
        bg_color = "#000000",
        fg_color = "#e0e0e0",
      },
    },
  },
  enable_tab_bar = true,
  use_fancy_tab_bar = false,
  window_frame = {
    font = wezterm.font("CaskaydiaCove Nerd Font"),
    font_size = 18.0,
    active_titlebar_bg = "#000000",
    inactive_titlebar_bg = "#000000",
    border_left_width = "0.1cell",
    border_right_width = "0.1cell",
    border_bottom_height = "0.05cell",
    border_top_height = "0.05cell",
    border_left_color = "#28313b",
    border_right_color = "#28313b",
    border_bottom_color = "#28313b",
    border_top_color = "#28313b",
  },
  window_padding = {
    top = 10,
    right = 10,
    bottom = 0,
    left = 10,
  },
  window_close_confirmation = "NeverPrompt",
}

return appearance
