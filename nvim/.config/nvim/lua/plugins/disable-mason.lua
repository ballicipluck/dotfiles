-- Disable mason and mason-lspconfig to avoid module not found errors
-- This is needed if you're managing LSP servers outside of Mason (e.g., via system packages)
return {
--   { "williamboman/mason.nvim", enabled = false },
--   { "williamboman/mason-lspconfig.nvim", enabled = false },
  { "mason-org/mason.nvim", enabled = false },
  { "mason-org/mason-lspconfig.nvim", enabled = false },
}
