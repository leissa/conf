-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local autocmd = vim.api.nvim_create_autocmd

-- open help in new tab
autocmd("FileType", { pattern = "help", command = "wincmd T" })

-- automatically open trouble quickfix
autocmd("QuickFixCmdPost", {
    callback = function()
        vim.cmd([[Trouble qflist open]])
    end,
})

-- remove trailing whitespaces
autocmd("BufWritePre", {
    pattern = { "*" },
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        pcall(function() vim.cmd [[%s/\s\+$//e]] end)
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Don't use crappy indent in LaTeX
