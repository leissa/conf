return {
    -- Active indent guide and indent text objects. When you're browsing code, this highlights the current level of indentation, and animates the highlighting.
    {
        "echasnovski/mini.indentscope",
        -- version = false, -- wait till new 0.7.0 release to put it back on semver
        lazy = false,
        opts = {
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function() vim.b.miniindentscope_disable = true end,
            })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            indent = {
                char     = "│",
                tab_char = "│",
            },
            scope = { enabled = false },
            exclude = {
                filetypes = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
            },
        },
        main = "ibl",
    },
    {
        'NMAC427/guess-indent.nvim',
        opts = {
            auto_cmd              = false,  -- Set to false to disable automatic execution
            override_editorconfig = false, -- Set to true to override settings set by .editorconfig
            filetype_exclude      = {      -- A list of filetypes for which the auto command gets disabled
                "netrw",
                "tutor",
            },
            buftype_exclude       = { -- A list of buffer types for which the auto command gets disabled
                "help",
                "nofile",
                "terminal",
                "prompt",
            },
        }
    }
}
