return {
  {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")
      notify.setup({
        stages = "fade_in_slide_out",
        timeout = 2000,
        max_width = 50,
        max_height = 10,
        background_color = "#000000",
      })
    end,
  }
}
