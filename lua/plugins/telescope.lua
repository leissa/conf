return {
    'nvim-telescope/telescope.nvim',
    branch       = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
        'debugloop/telescope-undo.nvim',
    },
    keys         = {
        { '<c-p>',      '<cmd>Telescope git_files<CR>',    desc = 'Telescope: git files' },
        { '<leader>fb', '<cmd>Telescope file_browser<CR>', desc = 'Telescope: file browers' },
        { '<leader>ff', '<cmd>Telescope find_files<CR>',   desc = 'Telescope: find_files' },
        { '<leader>fg', '<cmd>Telescope live_grep<CR>',    desc = 'Telescope: live_grep' },
    },
    config       = function()
        local telescope = require("telescope")
        local actions   = require("telescope.actions")

        telescope.setup {
            defaults = {
                -- path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-q>"] = actions.send_selected_to_qflist,
                    },
                },
            },
            pickers = {
                -- Default configuration for builtin pickers goes here:
                -- picker_name = {
                --   picker_config_key = value,
                --   ...
                -- }
                -- Now the picker_config_key will be applied every time you call this
                -- builtin picker
            },
            extensions = {
                file_browser = {
                    hijack_netrw = true, -- disables netrw and use telescope-file-browser in its place
                },
                undo = {
                },
            },
        }
        require("telescope").load_extension("undo")
        require("telescope").load_extension("file_browser")
    end,
    lazy         = false, -- needed for hijack_netrw
}
