-- Fix for mason-lspconfig.mappings error in LazyVim
-- This disables the problematic LazyVim LSP plugin and sets up LSP manually
return {
  -- Manually configure nvim-lspconfig
  -- This plugin provides configurations for various LSP servers
  {
    "neovim/nvim-lspconfig",
    -- Load when a file is opened (LazyFile is a LazyVim event)
    event = "LazyFile",
    -- Dependencies that must be loaded before lspconfig
    dependencies = {
      "mason.nvim",                      -- Package manager for LSP servers
      "mason-org/mason-lspconfig.nvim",  -- Bridge between mason and lspconfig
    },
    opts = {
      -- Define LSP servers and their configurations
      servers = {
        -- Lua language server configuration
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                -- Don't prompt about third-party libraries (like vim runtime)
                checkThirdParty = false,
              },
              codeLens = {
                -- Enable inline code lens (shows references, implementations, etc.)
                enable = true,
              },
              completion = {
                -- Use "Replace" mode for function call snippets
                callSnippet = "Replace",
              },
              doc = {
                -- Define what counts as private (starts with underscore)
                privateName = { "^_" },
              },
              hint = {
                -- Enable inlay hints (inline type information)
                enable = true,
                setType = false,         -- Don't show type hints for set operations
                paramType = true,        -- Show parameter type hints
                -- paramName = "Disable",   -- Don't show parameter names
                -- semicolon = "Disable",   -- Don't hint about missing semicolons
                -- arrayIndex = "Disable",  -- Don't show array index hints
              },
            },
          },
        },
      },
      -- Setup functions control how servers are initialized
      -- Returning true from a setup function prevents the default lspconfig setup
      setup = {
        -- Prevent formatters/linters from being configured as LSP servers
        -- These tools work through Mason but are not LSP servers
        stylua = function() return true end,     -- Lua formatter
        shellcheck = function() return true end, -- Shell script linter
        shfmt = function() return true end,      -- Shell script formatter
        flake8 = function() return true end,     -- Python linter
        -- Skip wildcard patterns that LazyVim might inject
        ["*"] = function() return true end,
      },
    },
    -- Custom config function that runs when the plugin loads
    config = function(_, opts)
      -- Setup LSP servers
      local servers = opts.servers
      
      -- Build capabilities object that tells servers what features Neovim supports
      -- This includes completion, snippets, etc.
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(), -- Base LSP capabilities
        require("blink.cmp").get_lsp_capabilities() or {} -- Add completion plugin capabilities
      )

      -- Function to setup a single LSP server
      local function setup(server)
        -- Merge server-specific options with capabilities
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities), -- Each server gets its own copy
        }, servers[server] or {})

        -- Check if there's a custom setup function for this server
        if opts.setup[server] then
          -- If the setup function returns true, skip default lspconfig setup
          if opts.setup[server](server, server_opts) then
            return
          end
        end
        
        -- Default setup: Use lspconfig to configure the server
        require("lspconfig")[server].setup(server_opts)
      end

      -- Loop through all defined servers and set them up
      for server, server_opts in pairs(servers) do
        -- Skip invalid server names and patterns
        -- Checks: 1) opts exist, 2) name is string, 3) no wildcards (* ? [ ])
        if server_opts and type(server) == "string" and not server:match("[%*%?%[%]]") then
          setup(server)
        end
      end
    end,
  },

  -- Mason LSP config
  -- Bridge plugin that integrates Mason package manager with lspconfig
  {
    "mason-org/mason-lspconfig.nvim",
    -- Only load when these commands are used
    cmd = { "LspInstall", "LspUninstall" },
    opts = {
      -- Automatically install LSP servers when you open a file that needs them
      automatic_installation = true,
    },
    -- Setup the plugin with the options
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },
}
