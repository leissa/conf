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
vim.g.mapleader      = ","
vim.g.maplocalleader = " "

-- indentation rules
vim.o.expandtab   = true
vim.o.autoindent  = true
vim.o.smartindent = true
vim.o.shiftround  = true
vim.o.tabstop     = 4
vim.o.softtabstop = 4
vim.o.shiftwidth  = 4

-- file handling
vim.o.autowrite = true
vim.o.confirm   = true
vim.o.hidden    = true

-- completion
vim.o.completeopt = "menu,menuone,longest,noinsert"
vim.o.wildmode    = "list:longest,full"

-- key mappings
vim.keymap.set('n',   '<F11>',  ':make! -j $(nproc)<CR>')
vim.keymap.set('n', '<S-F11>',  ':make! -j         <CR>')
vim.keymap.set('n', 'Y',        'y$')
vim.keymap.set('n', 'Q',        '@q')
vim.keymap.set('n', '<C-L>',    ':nohlsearch<CR><C-L>', { silent = true })

require"lazy".setup("plugins")

