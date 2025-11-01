return {
  {
    "nvim-mini/mini.pairs",
    opts = {
      modes = { insert = true, command = false, terminal = false },
      -- skip autopair when next character is any non-whitespace character
      skip_next = [=[[%S]]=],
      -- skip autopair when inside a string or comment
      skip_ts = { "string" },
      -- skip autopair when the cursor is just before a closing bracket
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
  },
}
