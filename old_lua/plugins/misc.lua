return {
    -- { 'echasnovski/mini.icons', version = false },
    {
        "folke/tokyonight.nvim",
        lazy     = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000,  -- make sure to load this before all the other start plugins
        opts     = {
            transparent = true,
            terminal_colors = true,
            style = "moon",
            styles = {
                -- sidebars = "transparent", -- style for sidebars, see below
                -- floats = "transparent",
            }
        },
        config   = function(_, opts)
            require("tokyonight").setup(opts)
            vim.opt.background    = 'dark'
            vim.opt.termguicolors = true
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
    { "j-hui/fidget.nvim",     opts = {} },
    {
        "jiriks74/presence.nvim",
        event = "UIEnter",
    },
    { 'stevearc/dressing.nvim' },
    {
        "danymat/neogen",
        config = true,
        keys = {
            { "<Leader>cn", "<cmd>lua require('neogen').generate()<CR>", desc = "Neogen" }
        }
    },
    { 'rhysd/clever-f.vim', },
    { 'brgmnn/vim-opencl' },
    { 'whonore/Coqtail' },
    { 'tpope/vim-commentary' },
    -- {
    --     'godlygeek/tabular',
    --     dependencies = { 'preservim/vim-markdown' },
    --     config = function()
    --         vim.g.vim_markdown_folding_disabled = 1
    --         vim.o.foldmethod                    = 'expr'
    --         vim.o.foldenable                    = false -- Disable folding at startup.
    --         vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]])
    --     end,
    -- },
    { 'leissa/vim-acme' },
    {
        'smoka7/hop.nvim',
        version = "*",
        config = true,
        keys = {
            { "<leader><leader>l", "<cmd>HopLine<cr>",  silent = true, mode = { "n", "v" }, desc = "Line" },
            { "<leader><leader>c", "<cmd>HopChar1<cr>", silent = true, mode = { "n", "v" }, desc = "1 Char" },
            { "<leader><leader>C", "<cmd>HopChar2<cr>", silent = true, mode = { "n", "v" }, desc = "2 Chars" },
            { "<leader><leader>w", "<cmd>HopWord<cr>",  silent = true, mode = { "n", "v" }, desc = "Word" },
        }
    },
    -- { 'tpope/vim-fugitive' },
    { 'tpope/vim-surround' },
    {
        'mizlan/iswap.nvim',
        keys = {
            { "<leader>is", "<cmd>ISwap<cr>",              silent = true, desc = "Swap" },
            { "<leader>iS", "<cmd>ISwapNode<cr>",          silent = true, desc = "Swap Node" },
            { "<leader>iw", "<cmd>ISwapWith<cr>",          silent = true, desc = "Swap with" },
            { "<leader>iW", "<cmd>ISwapNodeWith<cr>",      silent = true, desc = "Swap Node With" },
            { "<leader>ih", "<cmd>ISwapWithLeft<cr>",      silent = true, desc = "Swap with Left" },
            { "<leader>il", "<cmd>ISwapWithRight<cr>",     silent = true, desc = "Swap with Right" },
            { "<leader>iH", "<cmd>ISwapNodeWithLeft<cr>",  silent = true, desc = "Swap Node with Left" },
            { "<leader>iL", "<cmd>ISwapNodeWithRight<cr>", silent = true, desc = "Swap Node with Right" },
        }
    },
    -- { 'machakann/vim-swap' },
    { 'AnyDSL/vim-thorin2', ft = "thorin" },
}
