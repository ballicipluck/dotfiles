local function is_dark_mode()
  if vim.fn.has("macunix") ~= 1 then
    return true
  end

  local output = vim.fn.systemlist({ "defaults", "read", "-g", "AppleInterfaceStyle" })
  return output[1] == "Dark"
end

local function apply_theme()
  local dark_mode = is_dark_mode()
  local colorscheme

  if dark_mode then
    colorscheme = "tokyonight-moon"
  else
    vim.g.catppuccin_flavour = "latte"
    colorscheme = "catppuccin"
  end

  vim.opt.background = dark_mode and "dark" or "light"

  if vim.g.colors_name ~= colorscheme then
    vim.cmd.colorscheme(colorscheme)
  end
end

vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained" }, {
  callback = apply_theme,
})
