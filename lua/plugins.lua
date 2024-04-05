return {
    {
        -- "fneu/breezy",
        "folke/tokyonight.nvim",
        lazy     = false,   -- make sure we load this during startup if it is your main colorscheme
        priority = 1000,    -- make sure to load this before all the other start plugins
        config = function()
            vim.opt.background    = 'dark'
            vim.opt.termguicolors = true
            vim.cmd([[colorscheme tokyonight-night]])
        end,
    },
    {
        'numToStr/Comment.nvim',
        opts = {
            padding = true, -- Add a space b/w comment and the line
            sticky  = true, -- Whether the cursor should stay at its position
            ignore  = nil,  -- Lines to be ignored while (un)comment
            -- LHS of toggle mappings in NORMAL mode
            toggler = {
                line  = 'gcc', -- Line-comment toggle keymap
                block = 'gbc', -- Block-comment toggle keymap
            },
            -- LHS of operator-pending mappings in NORMAL and VISUAL mode
            opleader = {
                line  = 'gc', -- Line-comment keymap
                block = 'gb', -- Block-comment keymap
            },
            -- LHS of extra mappings
            extra = {
                above = 'gcO', -- Add comment on the line above
                below = 'gco', -- Add comment on the line below
                eol   = 'gcA', -- Add comment at the end of line
            },
            -- Enable keybindings
            -- NOTE: If given `false` then the plugin won't create any mappings
            mappings = {
                basic = true, ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                extra = true, ---Extra mapping; `gco`, `gcO`, `gcA`
            },
            pre_hook  = nil, ---Function to call before (un)comment
            post_hook = nil, ---Function to call after (un)comment
        },
        lazy = false,
    },
    {
        "ctrlpvim/ctrlp.vim",
        dependencies = {'DavidEGx/ctrlp-smarttabs'},
        config = function()
            vim.g.ctrlp_extensions = {'smarttabs'}
            vim.g.ctrlp_custom_ignore = {
                dir  = '\\v[\\/](\\.(git|hg|svn)|\\_site|build|modules|html|external)$',
                file = '\\v\\.(exe|so|dll|class|png|prg|jpg|jpeg|ll)$',
            }
        end,
    },
    {
        'nvimdev/dashboard-nvim',
        dependencies = {'nvim-tree/nvim-web-devicons'},
        event = 'VimEnter',
        opts = {
            theme = 'hyper',
            config = {
                week_header = {
                    enable = true,
                },
                shortcut = {
                    { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                    {
                        icon = ' ',
                        icon_hl = '@variable',
                        desc = 'Files',
                        group = 'Label',
                        action = 'Telescope find_files',
                        key = 'f',
                    },
                    {
                        desc = ' Apps',
                        group = 'DiagnosticHint',
                        action = 'Telescope app',
                        key = 'a',
                    },
                    {
                        desc = ' dotfiles',
                        group = 'Number',
                        action = 'Telescope dotfiles',
                        key = 'd',
                    },
                },
            },
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                icons_enabled = true,
                theme = 'tokyonight',
                component_separators = { left = '', right = ''},
                section_separators   = { left = '', right = ''},
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline    = 1000,
                    winbar     = 1000,
                }
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        },
    },
    -- {
    --     "nvim-neo-tree/neo-tree.nvim",
    --     dependencies = {
    --         'MunifTanjim/nui.nvim',
    --         'nvim-lua/plenary.nvim'
    --     },
    --     keys = {
    --         {"<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree"},
    --     },
    --     config = function()
    --         require("neo-tree").setup()
    --     end,
    -- },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },
    {
        'godlygeek/tabular',
        dependencies = {'preservim/vim-markdown'},
        config = function()
            vim.g.vim_markdown_folding_disabled = 1
        end,
    },
    {
        'nvim-telescope/telescope.nvim', 
        branch = '0.1.x',
        dependencies = {'nvim-lua/plenary.nvim'},
        opts = {
            extensions = {
                file_browser = {
                    hijack_netrw = true, -- disables netrw and use telescope-file-browser in its place
                },
            },
        },
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        keys = {
            {'<leader>fb', ':Telescope file_browser<CR>', desc = 'open file browers'},
        },
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
    {
        "Valloric/YouCompleteMe",
        ft = {"c", "cpp", "cs", "go", "java", "python", "python2", "javascript", "typescript", "rust" },
        build = "python install.py --all",
    },
}
