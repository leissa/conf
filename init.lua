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

vim.keymap.set('n', '<c-j>', ':bn<CR>',  { silent = true })
vim.keymap.set('n', '<c-k>', ':bp<CR>',  { silent = true })
vim.keymap.set('n',   '1gb', ':b  1<CR>', { silent = true })
vim.keymap.set('n',   '2gb', ':b  2<CR>', { silent = true })
vim.keymap.set('n',   '3gb', ':b  3<CR>', { silent = true })
vim.keymap.set('n',   '4gb', ':b  4<CR>', { silent = true })
vim.keymap.set('n',   '5gb', ':b  5<CR>', { silent = true })
vim.keymap.set('n',   '6gb', ':b  6<CR>', { silent = true })
vim.keymap.set('n',   '7gb', ':b  7<CR>', { silent = true })
vim.keymap.set('n',   '8gb', ':b  8<CR>', { silent = true })
vim.keymap.set('n',   '9gb', ':b  9<CR>', { silent = true })
vim.keymap.set('n',  '10gb', ':b 10<CR>', { silent = true })
vim.keymap.set('n',  '11gb', ':b 11<CR>', { silent = true })
vim.keymap.set('n',  '12gb', ':b 12<CR>', { silent = true })
vim.keymap.set('n',  '13gb', ':b 13<CR>', { silent = true })
vim.keymap.set('n',  '14gb', ':b 14<CR>', { silent = true })
vim.keymap.set('n',  '15gb', ':b 15<CR>', { silent = true })
vim.keymap.set('n',  '16gb', ':b 16<CR>', { silent = true })
vim.keymap.set('n',  '17gb', ':b 17<CR>', { silent = true })
vim.keymap.set('n',  '18gb', ':b 18<CR>', { silent = true })
vim.keymap.set('n',  '19gb', ':b 19<CR>', { silent = true })
vim.keymap.set('n',  '20gb', ':b 20<CR>', { silent = true })

require"lazy".setup("plugins")
