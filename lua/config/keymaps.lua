-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set
local del = vim.keymap.del

map("n", "<C-l>", "<cmd>nohlsearch<cr>", { silent = true, desc = "clear search highlighting" })
map("n", "Q", "@q")

-- make
map('n', '<F11>',   ':make! -j $(nproc)<CR>')
map('n', '<S-F11>',   ':make!<CR>')

-- Alternative for Home, Middle, Low
map({ "n", "v" }, "gh", "<S-h>", { desc = "Go Home" })
map({ "n", "v" }, "gm", "<S-m>", { desc = "Go Middle" })
map({ "n", "v" }, "gl", "<S-l>", { desc = "Go Low" })

-- Alternative for brackets in normal/visual mode
-- map({ "n", "v" }, "ö", "[", { desc = "[" })
-- map({ "n", "v" }, "ä", "]", { desc = "]" })

-- CLI/Window
map("n", "q:", "<Nop>", { desc = "Do *Not* open Commandline-Window" })
map("n", "q::", "q:", { desc = "Open Commandline-Window" })
map("c", "<c-j>", "<Down>")
map("c", "<c-k>", "<Up>")

-- Buffers
map("n", "<M-h>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move Buffer Prev" })
map("n", "<M-l>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move Buffer Next" })

-- remove LazyVim's "better indenting"
del("v", "<")
del("v", ">")

-- remove preset for quickfix/loclist and subistute later with quicker
-- del("n", "<leader>xq")
-- del("n", "<leader>xl")

