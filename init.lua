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

-- completion
-- vim.opt.completeopt = "menu,menuone,longest,noinsert"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.wildmode    = 'list:longest,full'

-- clipboard
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- key mappings
vim.keymap.set('n', '<F11>', ':make! -j $(nproc)<CR>')
vim.keymap.set('n', '<S-F11>', ':make! -j         <CR>')
vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set('n', 'Q', '@q')
vim.keymap.set('c', '<c-j>', '<Down>')
vim.keymap.set('c', '<c-k>', '<Up>')

-- working with buffers, tabs & windows
-- vim.keymap.set('n', '<c-j>', '<cmd>bn<CR>', { silent = true, desc = 'next buffer' })
-- vim.keymap.set('n', '<c-k>', '<cmd>bp<CR>', { silent = true, desc = 'prev buffer' })
-- vim.keymap.set('n', '<leader>q', '<cmd>bd<CR>', { silent = true, desc = 'close current buffer' })
vim.cmd([[autocmd FileType help wincmd T]]) -- open help in new tab

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
    return vim.fs.dirname(vim.fs.find(ptrns, { upward = true })[1])
end

require "lazy".setup("plugins")
