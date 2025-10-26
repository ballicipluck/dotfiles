-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

-- This early return is commented out so the actual plugin specs below will load
-- if true then return {
--   {'ThePrimeagen/vim-be-good'},
--   {
--     "mason-org/mason.nvim",
--     branch = "v1.x",
--     opts = {
--       ensure_installed = {
--         "stylua",
--         "shellcheck",
--         "shfmt",
--         "flake8",
--       },
--     },
--   },
--   {
--     "mason-org/mason-lspconfig.nvim",
--     branch = "v1.x",
--   },
-- } 
-- end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble
  { "folke/trouble.nvim", enabled = false },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "vim",
        "yaml",
      },
    },
  },

  -- add any tools you want to have installed below
  -- Note: These are formatters/linters, NOT LSP servers
  -- LSP servers should be configured in lsp.lua
  {
    "mason-org/mason.nvim",
    -- version = "^1.0.0",
    branch = "v1.x",
    opts = {
      ensure_installed = {
        "stylua",      -- Lua formatter
        "shellcheck",  -- Shell script linter
        "shfmt",       -- Shell script formatter
        "flake8",      -- Python linter
      },
    },
  },
}
