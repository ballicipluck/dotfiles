return {
  {
    "folke/snacks.nvim",
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("lazyvim_snacks", { clear = true }),
        callback = function()
          -- Always open explorer when starting nvim without a file
          if vim.fn.argc() == 0 then
            -- Small delay to ensure other plugins are loaded
            vim.defer_fn(function()
              require("snacks.explorer").open()
            end, 10)
          end
        end,
      })
    end,

    -- @type snacks.Config
    opts = {
      explorer = { replace_netrw = true },
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
