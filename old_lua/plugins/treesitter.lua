return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        opts = {
            ignore_install = { "latex" },
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
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "diff",
                "html",
                "java",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            },
        }
    },
    -- Show context of the current function
    {
        "nvim-treesitter/nvim-treesitter-context",
        cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
        opts = { mode = "cursor", max_lines = 3 },
        keys = {
            {
                "<leader>ut",
                function()
                    require("treesitter-context").toggle()
                end,
                desc = "Toggle Treesitter Context",
            },
        },
    },

    -- Automatically add closing tags for HTML and JSX
    {
        "windwp/nvim-ts-autotag",
        opts = {
            autotag = {
                enable = true
            }
        },
    },
}
