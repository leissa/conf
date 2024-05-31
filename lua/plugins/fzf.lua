return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config       = function()
        -- calling `setup` is optional for customization
        require 'fzf-lua'.setup {}
    end,
    keys         = {
        { "<C-p>",      "<leader>sf",                                                     desc = "Find Files (Root Dir)",   remap = true },
        -- buffers/tabs
        { "<leader>bb", "<cmd>FzfLua buffers<cr>",                                        desc = "Buffers" },
        { "<leader>bg", "<cmd>FzfLua lgrep_curbuf<cr>",                                   desc = "Buffer Grep" },
        { "<leader>bl", "<cmd>FzfLua blines<cr>",                                         desc = "Lines (buffer)" },
        { "<leader>bL", "<cmd>FzfLua lines<cr>",                                          desc = "Lines (project)" },
        { "<leader>bt", "<cmd>FzfLua tabs<cr>",                                           desc = "Tabs" },
        -- git
        { "<leader>gb", "<cmd>FzfLua git_branches<cr>",                                   desc = "Git Branches" },
        { "<leader>gc", "<cmd>FzfLua git_bcommits<cr>",                                   desc = "Git Commit log (buffer)" },
        { "<leader>gC", "<cmd>FzfLua git_commits<cr>",                                    desc = "Git Commit log (project)" },
        { "<leader>gf", "<cmd>FzfLua git_files<cr>",                                      desc = "Git Files" },
        { "<leader>gh", "<cmd>FzfLua git_stash<cr>",                                      desc = "Git Stas[h]" },
        { "<leader>gs", "<cmd>FzfLua git_status<cr>",                                     desc = "Git Status" },
        { "<leader>gt", "<cmd>FzfLua git_tags<cr>",                                       desc = "Git Tags" },
        -- search
        { "<leader>s",  "<cmd>FzfLua grep_visual<cr>",                                    desc = "search visual",           mode = "v" },
        { '<leader>s"', "<cmd>FzfLua registers<cr>",                                      desc = "Registers" },
        { "<leader>s:", "<cmd>FzfLua command_history<cr>",                                desc = "Command History" },
        { "<leader>s/", "<cmd>FzfLua search_history<cr>",                                 desc = "Search History" },
        { "<leader>sa", "<cmd>FzfLua autocommands<cr>",                                   desc = "Auto Commands" },
        { "<leader>sc", "<cmd>FzfLua commands<cr>",                                       desc = "Commands" },
        { "<leader>sC", "<cmd>lua require'fzf-lua'.files({ cwd = '~/.config' })<cr>",     desc = "Find Config File" },
        { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>",                           desc = "Diagnostics (document)" },
        { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>",                          desc = "Diagnostics (Workspace)" },
        { "<leader>sf", "<cmd>lua require'fzf-lua'.files({ cwd = Root()      })<cr>",     desc = "Find Files (Root Dir)" },
        { "<leader>sF", "<cmd>FzfLua files<cr>",                                          desc = "Find Files (cwd)" },
        { "<leader>sg", "<cmd>lua require'fzf-lua'.live_grep_glob({ cwd = Root() })<cr>", desc = "Grep (Root Dir)" },
        { "<leader>sG", "<cmd>FzfLua live_grep_glob<cr>",                                 desc = "Grep (cwd)" },
        { "<leader>sh", "<cmd>FzfLua helptags<cr>",                                       desc = "Help Pages" },
        { "<leader>sH", "<cmd>FzfLua highlights<cr>",                                     desc = "highLight Groups" },
        { "<leader>sk", "<cmd>FzfLua keymaps<cr>",                                        desc = "Key Maps" },
        { "<leader>sl", "<cmd>FzfLua loclist<cr>",                                        desc = "Location List" },
        { "<leader>sL", "<cmd>FzfLua loclist_stack<cr>",                                  desc = "Location Stack" },
        { "<leader>sm", "<cmd>FzfLua marks<cr>",                                          desc = "Jump to Mark" },
        { "<leader>so", "<cmd>FzfLua oldfiles<cr>",                                       desc = "Old Files" },
        { "<leader>sO", "<cmd>lua require'fzf-lua'.oldfiles({ cwd = vim.uv.cwd() })<cr>", desc = "Old Files (Root Dir)" },
        { "<leader>sp", "<cmd>FzfLua manpages<cr>",                                       desc = "Man Pages" },
        { "<leader>sq", "<cmd>FzfLua quickfix<cr>",                                       desc = "Quickfix List" },
        { "<leader>sQ", "<cmd>FzfLua quickfix_stack<cr>",                                 desc = "Quickfix Stack" },
        { "<leader>ss", "<cmd>FzfLua resume<cr>",                                         desc = "Re[s]ume" },
        {
            "<leader>st",
            function() require 'fzf-lua'.grep({ search = 'TODO|HACK|PERF|NOTE|FIX', no_esc = true }) end,
            desc = "Search TODO Comments"
        },
        { "<leader>sw", "<cmd>FzfLua grep_cword<cr>",                 desc = "word under cursor" },
        { "<leader>sW", "<cmd>FzfLua grep_cWORD<cr>",                 desc = "WORD under cursor" },
        { "<leader>sx", "<cmd>FzfLua changes<cr>",                    desc = "Changes [x]" },
        -- LSP
        { "<leader>la", "<cmd>FzfLua lsp_code_actions<cr>",           desc = "Code Actions" },
        { "<leader>ld", "<cmd>FzfLua lsp_definitions<cr>",            desc = "Definitions" },
        { "<leader>lD", "<cmd>FzfLua lsp_declarations<cr>",           desc = "Declarations" },
        { "<leader>lf", "<cmd>FzfLua lsp_finder<cr>",                 desc = "All LSP locations, combined view" },
        { "<leader>li", "<cmd>FzfLua lsp_incoming_calls<cr>",         desc = "Incoming Calls" },
        { "<leader>lI", "<cmd>FzfLua lsp_implementations<cr>",        desc = "Implementations" },
        { "<leader>lo", "<cmd>FzfLua lsp_outgoing_calls<cr>",         desc = "Outgoing Calls" },
        { "<leader>lr", "<cmd>FzfLua lsp_references<cr>",             desc = "References" },
        { "<leader>ls", "<cmd>FzfLua lsp_document_symbols<cr>",       desc = "Symbols (Document)" },
        { "<leader>lS", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "Symbols (Workspace)" },
        { "<leader>ly", "<cmd>FzfLua lsp_typedefs<cr>",               desc = "T[y]pe Definitions" },
        --- UI
        {
            "<leader>ub",
            function() require 'fzf-lua.actions'.toggle_bg() end,
            desc = "Toggle Background"
        },
        { "<leader>uc", "<cmd>FzfLua colorschemes<cr>",         desc = "Colorschemes" },
        { "<leader>uC", "<cmd>FzfLua awesome_colorschemes<cr>", desc = "Awesome Colorschemes" },
        --- tags
        { "<leader>t",  "<cmd>FzfLua tags_grep_visual<cr>",     desc = "tags_grep visual selection", mode = "v" },
        { "<leader>tt", "<cmd>FzfLua btags<cr>",                desc = "Search Buffer Tags" },
        { "<leader>tT", "<cmd>FzfLua tags_live_grep<cr>",       desc = "Search Project Tags" },
        { "<leader>tw", "<cmd>FzfLua tags_grep_cword<cr>",      desc = "Tags Grep word under cursor" },
        { "<leader>tW", "<cmd>FzfLua tags_grep_cWORD<cr>",      desc = "Tags Grep WORD under cursor" },
    },
}
