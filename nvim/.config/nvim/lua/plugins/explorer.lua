return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      -- ui_select = false,
      -- layout = { preset = "ivy" },
      sources = {
        explorer = {
          cycle = true,
          -- auto_close = true,
          layout = { preview = "main" },
        },
        files = {
          hidden = true,
          -- ignored = true,
        },
      },
      hidden = true,
      -- ignored = true,
    },
  },
}
