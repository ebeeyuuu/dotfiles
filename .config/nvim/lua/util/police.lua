local M = {}

function M.police()
  local notifications_triggered = {}

  local restricted_keys = {
    h = "Left",
    j = "Down",
    k = "Up",
    l = "Right",
    ["+"] = "Zoom In",
    ["-"] = "Zoom Out",
  }

  for key, description in pairs(restricted_keys) do
    local count = 0
    notifications_triggered[key] = false
    local timer = assert(vim.uv.new_timer())

    vim.keymap.set("n", key, function()
      if vim.v.count > 0 then
        count = 0
      end

      if count >= 10 and vim.bo.buftype ~= "nofile" then
        if not notifications_triggered[key] then
          notifications_triggered[key] = true
          vim.notify("Stop abusing the " .. description .. " key!", vim.log.levels.WARN, {
            icon = "👮",
            id = "police",
          })
        end
        return ""
      else
        count = count + 1
        timer:start(2000, 0, function()
          count = 0
        end)
        return key
      end
    end, { expr = true, silent = true })
  end
end

return M
