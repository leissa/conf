return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        opts = {
            ensure_installed = ft,
            -- auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection    = "gnn", -- set to `false` to disable one of the mappings
                    node_incremental  = "grn",
                    scope_incremental = "grc",
                    node_decremental  = "grm",
                },
            },
        },
        config = function(_, opts)
            require'nvim-treesitter.configs'.setup(opts)
            -- require'nvim-treesitter.install'.prefer_git = true
        end,
    }
}
