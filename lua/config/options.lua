-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Ensure proper font and icon rendering
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Enable termguicolors for better color support
vim.opt.termguicolors = true

-- Set guifont for GUI applications (like neovide)
vim.opt.guifont = "JetBrainsMono Nerd Font:h12"

-- Ensure proper icon display
vim.g.have_nerd_font = true


-- Line number configuration
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = false -- Disable relative line numbers (use static numbers)

-- Enable snacks dashboard/explorer by default
vim.g.snacks_animate = true