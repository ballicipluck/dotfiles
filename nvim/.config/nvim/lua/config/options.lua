-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LSP Server to use for Rust.
-- Set to "bacon-ls" to use bacon-ls instead of rust-analyzer.
-- only for diagnostics. The rest of LSP support will still be
-- provided by rust-analyzer.
vim.g.lazyvim_rust_diagnostics = "rust-analyzer"

-- Rust indentation settings for better RSX (Dioxus) support
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.bo.cindent = true
    vim.bo.cinoptions = "L0,(0,W4,m1"
    vim.bo.indentexpr = ""
  end,
})

-- Show inline diagnostics for Rust files
-- Configure diagnostics globally (applies to all filetypes including Rust)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    -- Set diagnostic display configuration
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
        source = "if_many",
        spacing = 4,
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })
  end,
})
