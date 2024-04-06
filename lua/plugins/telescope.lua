return {
    {
        'nvim-telescope/telescope.nvim', 
        branch  = '0.1.x',
        enabled = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            'debugloop/telescope-undo.nvim',
        },
        keys = {
            {'<leader>fb', ':Telescope file_browser<CR>', desc = 'open file browers'},
        },
        opts = {
            extensions = {
                file_browser = {
                    hijack_netrw = true, -- disables netrw and use telescope-file-browser in its place
                },
                undo = {
                },
            },
            mappings = {
                i = {
                    -- map actions.which_key to <C-h> (default: <C-/>)
                    -- actions.which_key shows the mappings for your picker,
                    -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                    --["<C-h>"] = "which_key"
                },
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("undo")
            require("telescope").load_extension("file_browser")
        end,
        lazy = false, -- needed for hijack_netrw
    },
}
