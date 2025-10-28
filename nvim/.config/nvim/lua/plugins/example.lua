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

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
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
        "rust",
        "ron",
        "vim",
        "yaml",
      },
    },
  },
}
