return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
      -- ["<CR>"] = false,
      ["<Tab>"] = { "accept", "fallback" },
    },
    completion = {
      show_on_keyword = true,
      show_on_insert = false,
    },
  },
}
