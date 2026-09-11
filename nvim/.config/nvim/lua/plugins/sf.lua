return {
  {
    "ItsMe-MIT/sf.nvim",
    branch = "enhance/floating-terminal-outputs",
    ft = { "apex", "visualforce", "cls", "trigger" },
    keys = {
      { "<leader>so", "<cmd>SfOrgList<cr>", desc = "SF: List Orgs" },
      { "<leader>sO", "<cmd>SfOrgOpen<cr>", desc = "SF: Open Org" },
      { "<leader>sl", "<cmd>SfOrgLogin<cr>", desc = "SF: Login" },
      { "<leader>sd", "<cmd>SfDeployFile<cr>", desc = "SF: Deploy File" },
      { "<leader>sD", "<cmd>SfDeploy<cr>", desc = "SF: Deploy" },
      { "<leader>sF", "<cmd>SfRetrieveFile<cr>", desc = "SF: Retrieve File" },
      { "<leader>sR", "<cmd>SfRetrieve<cr>", desc = "SF: Retrieve" },
      { "<leader>st", "<cmd>SfTestRunClass<cr>", desc = "SF: Run Tests" },
      { "<leader>sT", "<cmd>SfTestRunAll<cr>", desc = "SF: Run All Tests" },
      { "<leader>sc", "<cmd>SfApexCreateClass<cr>", desc = "SF: Create Class" },
      { "<leader>se", "<cmd>SfApexExecute<cr>", desc = "SF: Execute Apex" },
      { "<leader>sf", "<cmd>SfDataQuery<cr>", desc = "SF: SOQL Query" },
    },
    config = function()
      require("sf").setup({
        log = {
          level = "debug",
        },
      })
    end,
  }
}
