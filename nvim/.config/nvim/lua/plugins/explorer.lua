return {
  {
    "folke/snacks.nvim",
    -- @type snacks.Config
    opts = {
      explorer = {
        replace_netrw = true,
      },
      dashboard = { enabled = false },
      picker = {
        ui_select = false,
        -- Preview in a separate floating window, not the main buffer
        -- previewers = {
        --   file = {
        --     -- Preview buffers are scratch buffers that don't affect the buffer list
        --     scratch = true,
        --   },
        -- },
        sources = {
          explorer = {
            follow_file = true,
            tree = true,
            cycle = true,
            auto_close = true,
            -- Don't use main buffer for preview
            layout = {
              preview = "main",
              layout = {
                position = "right",
              },
            },
          },
          files = {
            hidden = true,
          },
        },
        hidden = true,
      },
    },
    keys = {
      -- Override LazyVim's default to use cwd instead of LazyVim.root()
      -- This prevents the root from jumping around
      -- {
      --   "<leader>fe",
      --   function()
      --     Snacks.explorer({ cwd = vim.fn.getcwd() })
      --   end,
      --   desc = "Explorer Snacks (cwd)",
      -- },
      {
        "<leader>e",
        function()
          Snacks.explorer({ cwd = vim.fn.getcwd() })
        end,
        desc = "Explorer Snacks (cwd)",
      },
    },
    init = function()
      -- Open explorer on startup when no file is specified
      vim.api.nvim_create_autocmd("UIEnter", {
        group = vim.api.nvim_create_augroup("custom_explorer_startup", { clear = true }),
        once = true,
        callback = function()
          if vim.fn.argc() == 0 then
            -- Delay to ensure UI is fully initialized
            vim.defer_fn(function()
              Snacks.explorer.open({ cwd = vim.fn.getcwd() })
            end, 50)
          end
        end,
      })
    end,
  },
}
