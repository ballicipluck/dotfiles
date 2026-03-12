-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "x", '"_x', { desc = "Delete character without yanking" })
vim.keymap.set("x", "x", '"_d', { desc = "Delete selection without yanking" })
vim.keymap.set("n", "X", '"_diw', { desc = "Delete word without yanking" })
vim.keymap.set("x", "X", '"_d', { desc = "Delete selection without yanking" })
