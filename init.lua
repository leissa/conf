-- setup lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- leaders

vim.g.mapleader      = " "
vim.g.maplocalleader = ","

-- search

vim.opt.ignorecase   = true
vim.opt.smartcase    = true
vim.keymap.set('n', '<C-l>', '<cmd>nohlsearch<cr>', { silent = true })

-- indentation rules

function MyIndent()
    vim.opt.expandtab   = true
    vim.opt.autoindent  = true
    vim.opt.shiftround  = true
    vim.opt.tabstop     = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth  = 4
end

MyIndent()

-- file handling

vim.opt.autowrite   = true
vim.opt.confirm     = true
vim.opt.hidden      = true
-- vim.opt.conceallevel = 2

-- completion

vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.wildmode    = 'list:longest,full'

-- clipboard

-- vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- key mappings

vim.keymap.set('n', '<F11>', ':make! -j $(nproc)<CR>')
vim.keymap.set('n', '<S-F11>', ':make! -j         <CR>')
vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set('n', 'Q', '@q')
vim.keymap.set('c', '<c-j>', '<Down>')
vim.keymap.set('c', '<c-k>', '<Up>')

vim.keymap.set({'n', 'v'}, 'gh', '<S-h>', { desc = "Go Home" })
vim.keymap.set({'n', 'v'}, 'gm', '<S-m>', { desc = "Go Middle" })
vim.keymap.set({'n', 'v'}, 'gl', '<S-l>', { desc = "Go Low" })

vim.keymap.set('n', 'q:', '<Nop>', { desc = "Go Low" })
vim.keymap.set('n', 'q::', 'q:', { desc = "Open Commandline-Window" })

-- diagnostic
local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end

vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

local icons = require 'icons'

vim.diagnostic.config({
    virtual_text  = false,
    severity_sort = false,
    signs         = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
        },
    },
    float         = {
        border = 'rounded',
        source = true,
    }
})

-- Show line diagnostics automatically in hover window
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- autocmd

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
    pattern = "help",
    command = "wincmd T", -- open help in new tab
})

-- line numering


--[[
vim.opt.number         = true
vim.opt.relativenumber = true
local numbertoggle = augroup("numbertoggle", { clear = true })

autocmd({"BufEnter", "FocusGained", "InsertLeave", "WinEnter"}, {
    group   = numbertoggle,
    pattern = "*",
    callback = function()
        if vim.opt.number and vim.api.nvim_get_mode() ~= 'i' then
            vim.opt.relativenumber = true
        end
    end
})
autocmd({"BufLeave", "FocusLost", "InsertEnter", "WinLeave"}, {
    group   = numbertoggle,
    pattern  = "*",
    callback = function()
        if vim.opt.number then
            vim.opt.relativenumber = false
        end
    end
})
]]

-- remove trailing whitespaces

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        pcall(function() vim.cmd [[%s/\s\+$//e]] end)
        vim.fn.setpos(".", save_cursor)
    end,
})

function Root()
    local ptrns = { ".git", ".clang-format", "pyproject.toml", "setup.py", ".svn" }
    local cwd   = vim.uv.cwd()
    local res   = vim.fs.root(cwd and cwd or 0, ptrns)
    return res and res or cwd
end

require "lazy".setup("plugins")
