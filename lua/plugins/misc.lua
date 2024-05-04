return {
    {
        "folke/tokyonight.nvim",
        lazy     = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000,  -- make sure to load this before all the other start plugins
        config   = function()
            vim.opt.background    = 'dark'
            vim.opt.termguicolors = true
            vim.cmd([[colorscheme tokyonight-night]])
        end,
    },
    { 'stevearc/dressing.nvim' },
    {
        "danymat/neogen",
        config = true,
        keys = {
            { "<Leader>cn", ":lua require('neogen').generate()<CR>", desc = "Neogen" }
        }
    },
    { 'brgmnn/vim-opencl' },
    { 'tpope/vim-commentary' },
    {
        'godlygeek/tabular',
        dependencies = { 'preservim/vim-markdown' },
        config = function()
            vim.g.vim_markdown_folding_disabled = 1
            vim.o.foldmethod                    = 'expr'
            vim.o.foldenable                    = false -- Disable folding at startup.
            vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]])
        end,
    },
    { 'leissa/vim-acme' },
    {
        'smoka7/hop.nvim',
        version = "*",
        config = true,
        keys = {
            { "<leader><leader>l", "<cmd>HopLine<cr>",  silent = true, desc = "Line" },
            { "<leader><leader>c", "<cmd>HopChar1<cr>", silent = true, desc = "1 Char" },
            { "<leader><leader>C", "<cmd>HopChar2<cr>", silent = true, desc = "2 Chars" },
            { "<leader><leader>w", "<cmd>HopWord<cr>",  silent = true, desc = "Word" },
        }
    },
    -- { 'tpope/vim-fugitive' },
    { 'preservim/vim-markdown' },
    { 'tpope/vim-surround' },
    { 'machakann/vim-swap' },
    { 'AnyDSL/vim-thorin2',    ft = "thorin" },
}
