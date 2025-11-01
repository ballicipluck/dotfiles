return {
  -- Disable the dashboard plugin completely
  {
    "nvimdev/dashboard-nvim",
    enabled = false,
  },
  -- Also ensure snacks dashboard is disabled
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false },
    },
  },
}
