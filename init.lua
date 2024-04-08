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
function MyIndent()
    vim.o.expandtab   = true
    vim.o.autoindent  = true
    vim.o.smartindent = true
    vim.o.shiftround  = true
    vim.o.tabstop     = 4
    vim.o.softtabstop = 4
    vim.o.shiftwidth  = 4
end

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

vim.keymap.set('n', '<c-j>', '<cmd>bn<CR>',  { silent = true })
vim.keymap.set('n', '<c-k>', '<cmd>bp<CR>',  { silent = true })
vim.keymap.set('n',   '1gb', '<cmd>b  1<CR>', { silent = true })
vim.keymap.set('n',   '2gb', '<cmd>b  2<CR>', { silent = true })
vim.keymap.set('n',   '3gb', '<cmd>b  3<CR>', { silent = true })
vim.keymap.set('n',   '4gb', '<cmd>b  4<CR>', { silent = true })
vim.keymap.set('n',   '5gb', '<cmd>b  5<CR>', { silent = true })
vim.keymap.set('n',   '6gb', '<cmd>b  6<CR>', { silent = true })
vim.keymap.set('n',   '7gb', '<cmd>b  7<CR>', { silent = true })
vim.keymap.set('n',   '8gb', '<cmd>b  8<CR>', { silent = true })
vim.keymap.set('n',   '9gb', '<cmd>b  9<CR>', { silent = true })
vim.keymap.set('n',  '10gb', '<cmd>b 10<CR>', { silent = true })
vim.keymap.set('n',  '11gb', '<cmd>b 11<CR>', { silent = true })
vim.keymap.set('n',  '12gb', '<cmd>b 12<CR>', { silent = true })
vim.keymap.set('n',  '13gb', '<cmd>b 13<CR>', { silent = true })
vim.keymap.set('n',  '14gb', '<cmd>b 14<CR>', { silent = true })
vim.keymap.set('n',  '15gb', '<cmd>b 15<CR>', { silent = true })
vim.keymap.set('n',  '16gb', '<cmd>b 16<CR>', { silent = true })
vim.keymap.set('n',  '17gb', '<cmd>b 17<CR>', { silent = true })
vim.keymap.set('n',  '18gb', '<cmd>b 18<CR>', { silent = true })
vim.keymap.set('n',  '19gb', '<cmd>b 19<CR>', { silent = true })
vim.keymap.set('n',  '20gb', '<cmd>b 20<CR>', { silent = true })

-- remove trailing whitespaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = {"*"},
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        pcall(function() vim.cmd [[%s/\s\+$//e]] end)
        vim.fn.setpos(".", save_cursor)
    end,
})

-- open help in new tab
vim.cmd([[autocmd FileType help wincmd T]])

require"lazy".setup("plugins")
