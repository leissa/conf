-- This will return a function that calls telescope.
-- cwd will default to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
-- @param builtin string
-- @param opts? lazyvim.util.telescope.opts
function Telescope(builtin, opts)
    local params = { builtin = builtin, opts = opts }
    return function()
        builtin = params.builtin
        opts = params.opts
        opts = vim.tbl_deep_extend("force", { cwd = Root() }, opts or {}) -- [[@as lazyvim.util.telescope.opts]]
        if builtin == "files" then
            if
                vim.uv.fs_stat((opts.cwd or vim.uv.cwd()) .. "/.git")
                and not vim.uv.fs_stat((opts.cwd or vim.uv.cwd()) .. "/.ignore")
                and not vim.uv.fs_stat((opts.cwd or vim.uv.cwd()) .. "/.rgignore")
            then
                if opts.show_untracked == nil then
                    opts.show_untracked = true
                end
                builtin = "git_files"
            else
                builtin = "find_files"
            end
        end
        if opts.cwd and opts.cwd ~= vim.uv.cwd() then
            local function open_cwd_dir()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()
                Telescope(params.builtin,
                    vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line }))()
            end
            ---@diagnostic disable-next-line: inject-field
            opts.attach_mappings = function(_, map)
                -- opts.desc is overridden by telescope, until it's changed there is this fix
                map("i", "<a-c>", open_cwd_dir, { desc = "Open cwd Directory" })
                return true
            end
        end

        require("telescope.builtin")[builtin](opts)
    end
end

function Config_files()
    return Telescope("find_files", { cwd = vim.fn.stdpath("config") })
end

local kind_filter = {
    default = {
        "Class",
        "Constructor",
        "Enum",
        "Field",
        "Function",
        "Interface",
        "Method",
        "Module",
        "Namespace",
        "Package",
        "Property",
        "Struct",
        "Trait",
    },
    markdown = false,
    help = false,
    -- you can specify a different filter for each filetype
    lua = {
        "Class",
        "Constructor",
        "Enum",
        "Field",
        "Function",
        "Interface",
        "Method",
        "Module",
        "Namespace",
        -- "Package", -- remove package since luals uses it for control flow structures
        "Property",
        "Struct",
        "Trait",
    },
}

local function get_kind_filter(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
  local ft = vim.bo[buf].filetype
  if kind_filter == false then
    return
  end
  if kind_filter[ft] == false then
    return
  end
  if type(kind_filter[ft]) == "table" then
    return kind_filter[ft]
  end
  ---@diagnostic disable-next-line: return-type-mismatch
  return type(kind_filter) == "table" and type(kind_filter.default) == "table" and kind_filter.default or nil
end

return {
    'nvim-telescope/telescope.nvim',
    branch       = '0.1.x',
    lazy         = false, -- needed for hijack_netrw
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
        'debugloop/telescope-undo.nvim',
    },
    keys         = {
        {
            "<leader>,",
            "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
            desc = "Switch Buffer",
        },
        { "<leader>/",  Telescope("live_grep"),                                        desc = "Grep (Root Dir)" },
        { "<leader>:",  "<cmd>Telescope command_history<cr>",                          desc = "Command History" },
        -- { "<leader><space>", Telescope("files"), desc = "Find Files (Root Dir)" },
        -- find
        { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
        { "<leader>fc", Config_files(),                                                desc = "Find Config File" },
        { "<leader>ff", Telescope("files"),                                            desc = "Find Files (Root Dir)" },
        { "<C-p>",      Telescope("files"),                                            desc = "Find Files (Root Dir)" }, -- same as above
        { "<leader>fF", Telescope("files", { cwd = false }),                           desc = "Find Files (cwd)" },
        { "<leader>fg", "<cmd>Telescope git_files<cr>",                                desc = "Find Files (git-files)" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                                 desc = "Recent" },
        { "<leader>fR", Telescope("oldfiles", { cwd = vim.uv.cwd() }),                 desc = "Recent (cwd)" },
        -- git
        { "<leader>gc", "<cmd>Telescope git_commits<CR>",                              desc = "Commits" },
        { "<leader>gs", "<cmd>Telescope git_status<CR>",                               desc = "Status" },
        -- search
        { '<leader>s"', "<cmd>Telescope registers<cr>",                                desc = "Registers" },
        { "<leader>sa", "<cmd>Telescope autocommands<cr>",                             desc = "Auto Commands" },
        { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>",                desc = "Buffer" },
        { "<leader>sc", "<cmd>Telescope command_history<cr>",                          desc = "Command History" },
        { "<leader>sC", "<cmd>Telescope commands<cr>",                                 desc = "Commands" },
        { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>",                      desc = "Document Diagnostics" },
        { "<leader>sD", "<cmd>Telescope diagnostics<cr>",                              desc = "Workspace Diagnostics" },
        { "<leader>sg", Telescope("live_grep"),                                        desc = "Grep (Root Dir)" },
        { "<leader>sG", Telescope("live_grep", { cwd = false }),                       desc = "Grep (cwd)" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>",                                desc = "Help Pages" },
        { "<leader>sH", "<cmd>Telescope highlights<cr>",                               desc = "Search Highlight Groups" },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>",                                  desc = "Key Maps" },
        { "<leader>sM", "<cmd>Telescope man_pages<cr>",                                desc = "Man Pages" },
        { "<leader>sm", "<cmd>Telescope marks<cr>",                                    desc = "Jump to Mark" },
        { "<leader>so", "<cmd>Telescope vim_options<cr>",                              desc = "Options" },
        { "<leader>sR", "<cmd>Telescope resume<cr>",                                   desc = "Resume" },
        { "<leader>sw", Telescope("grep_string", { word_match = "-w" }),               desc = "Word (Root Dir)" },
        { "<leader>sW", Telescope("grep_string", { cwd = false, word_match = "-w" }),  desc = "Word (cwd)" },
        { "<leader>sw", Telescope("grep_string"),                                      mode = "v",                       desc = "Selection (Root Dir)" },
        { "<leader>sW", Telescope("grep_string", { cwd = false }),                     mode = "v",                       desc = "Selection (cwd)" },
        { "<leader>uC", Telescope("colorscheme", { enable_preview = true }),           desc = "Colorscheme with Preview" },
        {
            "<leader>ss",
            function()
                require("telescope.builtin").lsp_document_symbols({
                    symbols = get_kind_filter(),
                })
            end,
            desc = "Goto Symbol",
        },
        {
            "<leader>sS",
            function()
                require("telescope.builtin").lsp_dynamic_workspace_symbols({
                    symbols = get_kind_filter(),
                })
            end,
            desc = "Goto Symbol (Workspace)",
        },
    },
    opts         = function()
        local actions = require("telescope.actions")

        local open_with_trouble = function(...)
            return require("trouble.providers.telescope").open_with_trouble(...)
        end
        local open_selected_with_trouble = function(...)
            return require("trouble.providers.telescope").open_selected_with_trouble(...)
        end
        local find_files_no_ignore = function()
            local action_state = require("telescope.actions.state")
            local line = action_state.get_current_line()
            Telescope("find_files", { no_ignore = true, default_text = line })()
        end
        local find_files_with_hidden = function()
            local action_state = require("telescope.actions.state")
            local line = action_state.get_current_line()
            Telescope("find_files", { hidden = true, default_text = line })()
        end

        return {
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                -- open files in the first window that is an actual file.
                -- use the current window if no other window is available.
                get_selection_window = function()
                    local wins = vim.api.nvim_list_wins()
                    table.insert(wins, 1, vim.api.nvim_get_current_win())
                    for _, win in ipairs(wins) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        if vim.bo[buf].buftype == "" then
                            return win
                        end
                    end
                    return 0
                end,
                mappings = {
                    i = {
                        ["<C-Down>"] = actions.cycle_history_next,
                        ["<C-Up>"] = actions.cycle_history_prev,
                        ["<C-b>"] = actions.preview_scrolling_up,
                        ["<C-f>"] = actions.preview_scrolling_down,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<A-h>"] = find_files_with_hidden,
                        ["<A-i>"] = find_files_no_ignore,
                        ["<A-t>"] = open_selected_with_trouble,
                        ["<C-t>"] = open_with_trouble,
                    },
                    n = {
                        ["q"] = actions.close,
                    },
                },
            },
        }
    end,
}
