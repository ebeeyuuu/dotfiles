local wezterm = require("wezterm")

local function is_found(str, pattern)
  return string.find(str, pattern) ~= nil
end

--@alias PlatformType "windows" | "linux" | "mac"

--@return {os: PlatformType, is_win: boolean, is_linux: boolean, is_mac: boolean}
local function platform()
  local is_win = is_found(wezterm.target_triple, "windows")
  local is_linux = is_found(wezterm.target_triple, "linux")
  local is_mac = is_found(wezterm.target_triple, "apple")
  local os

  if is_win then
    os = "windows"
  elseif is_linux then
    os = "linux"
  elseif is_mac then
    os = "mac"
  end

  return {
    os = os,
    is_win = is_win,
    is_linux = is_linux,
    is_mac = is_mac,
  }
end

local theplatform = platform()

local mod = {}
if theplatform.is_mac then
  mod.SUPER = "SUPER"
  mod.SUPER_REV = "SUPER|CTRL"
elseif theplatform.is_win or theplatform.is_linux then
  mod.SUPER = "ALT" -- Avoid conflicts with Windows key shortcuts
  mod.SUPER_REV = "ALT|CTRL"
end

local keys = {
  { key = "F1",         mods = "NONE",        action = "ActivateCopyMode" },
  { key = "F2",         mods = "NONE",        action = wezterm.action.ActivateCommandPalette },
  { key = "F3",         mods = "NONE",        action = wezterm.action.ShowLauncher },
  { key = "F4",         mods = "NONE",        action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|TABS" }) },
  { key = "F5",         mods = "NONE",        action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
  { key = "F11",        mods = "NONE",        action = wezterm.action.ToggleFullScreen },
  { key = "F12",        mods = "NONE",        action = wezterm.action.ShowDebugOverlay },
  { key = "f",          mods = mod.SUPER,     action = wezterm.action.Search({ CaseInSensitiveString = "" }) },

  { key = "LeftArrow",  mods = mod.SUPER,     action = wezterm.action.SendString "\x1bOH" },
  { key = "RightArrow", mods = mod.SUPER,     action = wezterm.action.SendString "\x1bOF" },
  { key = "Backspace",  mods = mod.SUPER,     action = wezterm.action.SendString "\x15" },

  { key = "t",          mods = mod.SUPER,     action = wezterm.action.SpawnTab("DefaultDomain") },
  { key = "t",          mods = mod.SUPER_REV, action = wezterm.action.SpawnTab({ DomainName = "WSL:Ubuntu" }) },
  { key = "w",          mods = mod.SUPER_REV, action = wezterm.action.CloseCurrentTab({ confirm = false }) },
  { key = "[",          mods = mod.SUPER,     action = wezterm.action.ActivateTabRelative(-1) },
  { key = "]",          mods = mod.SUPER,     action = wezterm.action.ActivateTabRelative(1) },
  { key = "[",          mods = mod.SUPER_REV, action = wezterm.action.MoveTabRelative(-1) },
  { key = "]",          mods = mod.SUPER_REV, action = wezterm.action.MoveTabRelative(1) },

  { key = "n",          mods = mod.SUPER,     action = wezterm.action.SpawnWindow },
  {
    key = "-",
    mods = "CMD|SHIFT",
    action = wezterm.action.DecreaseFontSize,
  },
  {
    key = "=",
    mods = "CMD|SHIFT",
    action = wezterm.action.IncreaseFontSize,
  },
  {
    key = "m",
    mods = "CMD",
    action = wezterm.action_callback(function(window, _)
      wezterm.run_child_process({
        "osascript",
        "-e",
        [[
        tell application "System Events"
          tell process "WezTerm"
            set value of attribute "AXMinimized" of window 1 to true
          end tell
        end tell
        ]]
      })
    end),
  },

  { key = [[\]],   mods = mod.SUPER,     action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = [[\]],   mods = mod.SUPER_REV, action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "Enter", mods = mod.SUPER,     action = wezterm.action.TogglePaneZoomState },
  { key = "w",     mods = mod.SUPER,     action = wezterm.action.CloseCurrentPane({ confirm = false }) },
  { key = "k",     mods = mod.SUPER_REV, action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "j",     mods = mod.SUPER_REV, action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "h",     mods = mod.SUPER_REV, action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "l",     mods = mod.SUPER_REV, action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "p",     mods = mod.SUPER_REV, action = wezterm.action.PaneSelect({ alphabet = "1234567890", mode = "SwapWithActiveKeepFocus" }) },

  -- Key Tables
  { key = "f",     mods = "LEADER",      action = wezterm.action.ActivateKeyTable({ name = "resize_font", one_shot = false, timeout_milliseconds = 1000 }) },
  { key = "p",     mods = "LEADER",      action = wezterm.action.ActivateKeyTable({ name = "resize_pane", one_shot = false, timeout_milliseconds = 1000 }) },
}

for i = 1, 9 do
  table.insert(keys, {
    key = tostring(i),
    mods = mod.SUPER,
    action = wezterm.action.ActivateTab(i - 1),
  })
end

local key_tables = {
  resize_font = {
    { key = "k",      action = wezterm.action.IncreaseFontSize },
    { key = "j",      action = wezterm.action.DecreaseFontSize },
    { key = "r",      action = wezterm.action.ResetFontSize },
    { key = "Escape", action = "PopKeyTable" },
    { key = "q",      action = "PopKeyTable" },
  },
  resize_pane = {
    { key = "k",      action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
    { key = "j",      action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
    { key = "h",      action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
    { key = "l",      action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "q",      action = "PopKeyTable" },
  },
}

local mouse_bindings = {
  { event = { Up = { streak = 1, button = "Left" } }, mods = "CTRL", action = wezterm.action.OpenLinkAtMouseCursor },
}

return {
  disable_default_key_bindings = true,
  leader = { key = "Space", mods = mod.SUPER_REV },
  keys = keys,
  key_tables = key_tables,
  mouse_bindings = mouse_bindings,
}
