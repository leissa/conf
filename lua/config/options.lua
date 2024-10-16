-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
local g = vim.g

-- indent
opt.expandtab = true
opt.autoindent = true
opt.shiftround = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

-- editor
opt.number = false
opt.relativenumber = false
opt.conceallevel = 0

-- completion
opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
opt.wildmode = "list:longest,full"

-- misc
g.maplocalleader = "ö"
g.root_spec = { ".git", "lsp", "cwd" }
g.autoformat = false -- no autoformat on write
