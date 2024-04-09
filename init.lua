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
vim.opt.swapfile    = false

-- completion
vim.opt.completeopt = "menu,menuone,longest,noinsert"
vim.opt.wildmode    = 'list:longest,full'

-- clipboard
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- key mappings
vim.keymap.set('n', '<F11>', ':make! -j $(nproc)<CR>')
vim.keymap.set('n', '<S-F11>', ':make! -j         <CR>')
vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set('n', 'Q', '@q')

-- working with buffers, tabs & windows
vim.keymap.set('n', '<c-j>', '<cmd>bn<CR>', { silent = true, desc = 'next buffer' })
vim.keymap.set('n', '<c-k>', '<cmd>bp<CR>', { silent = true, desc = 'prev buffer' })
vim.keymap.set('n', '<leader>qq', '<cmd>bd<CR>', { silent = true, desc = 'close current buffer' })
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


require "lazy".setup("plugins")
