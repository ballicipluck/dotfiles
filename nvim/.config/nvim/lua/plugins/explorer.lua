return {
  {
    "folke/snacks.nvim",
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("lazyvim_snacks", { clear = true }),
        callback = function()
          if vim.fn.argc() == 0 then
            require("snacks.explorer").open()
          end
        end,
      })
    end,

    -- @type snacks.Config
    opts = {
      -- explorer = { replace_netrw = true },
      dashboard = { enabled = false },
      picker = {
        ui_select = false,
        -- layout = { preset = "ivy" },
        sources = {
          explorer = {
            cycle = true,
            auto_close = true,
            layout = {
              preview = "main",
              -- preset = "ivy",
              layout = {
                position = "right",
              },
            },
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
  },
}
