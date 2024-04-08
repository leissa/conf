return {
    {
        "folke/tokyonight.nvim",
        lazy     = false,   -- make sure we load this during startup if it is your main colorscheme
        priority = 1000,    -- make sure to load this before all the other start plugins
        config = function()
            vim.opt.background    = 'dark'
            vim.opt.termguicolors = true
            vim.cmd([[colorscheme tokyonight-night]])
        end,
    },
    { 'stevearc/dressing.nvim' },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require'gitsigns'.setup()
        end
    },
    {
        'godlygeek/tabular',
        dependencies = {'preservim/vim-markdown'},
        config = function()
            vim.g.vim_markdown_folding_disabled = 1
            vim.o.foldmethod                    = 'expr'
            vim.o.foldenable                    = false    -- Disable folding at startup.
            vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]])
        end,
    },
    { 'leissa/vim-acme' },
    { 'easymotion/vim-easymotion' },
    {
        'derekwyatt/vim-fswitch',
        ft = {"c", "cpp"},
        keys = {
            {'ö', ':FSSplitRight<CR>', desc='Switch to the file and load it into a new window split on the right'},
            {'Ö', ':FSSplitLeft<CR>',  desc='Switch to the file and load it into a new window split on the left'},
        },
    },
    { 'tpope/vim-fugitive' },
    { 'preservim/vim-markdown' },
    { 'tpope/vim-surround' },
    { 'machakann/vim-swap' },
    { 'AnyDSL/vim-thorin2', ft = "thorin" },
    {
        "lervag/vimtex",
        ft = "tex",
        init = function()
            vim.g.vimtex_view_general_viewer     = 'okular'
            vim.g.vimtex_view_general_options    = '--unique file:@pdf\\#src:@line@tex'
            vim.g.vimtex_quickfix_ignore_filters = {
                'Marginpar on page',
                'Overfull',
                'Underfull',
                'Missing ".*" in',
                'todonotes Warning',
                'Font shape.*',
                'cannot apply log',
            }
        end
    },
}
