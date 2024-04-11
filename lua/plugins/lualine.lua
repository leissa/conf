local icons = require 'icons'
return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            icons_enabled = true,
            theme = 'tokyonight',
            globalstatus = true,
            disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        },
        lualine_c = {
            Root(),
            {
                "diagnostics",
                symbols = {
                    error = icons.diagnostics.Error,
                    warn  = icons.diagnostics.Warn,
                    info  = icons.diagnostics.Info,
                    hint  = icons.diagnostics.Hint,
                },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            -- { vim. LazyVim.lualine.pretty_path() },
        },
        lualine_x = {
            {
                function() return require("noice").api.status.command.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                color = vim.api.nvim_get_hl(0, { name = "Statement" }),
            },
            {
                function() return require("noice").api.status.mode.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                color = vim.api.nvim_get_hl(0, { name = "Constant" }),
            },
            {
                function() return "  " .. require("dap").status() end,
                cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                color = vim.api.nvim_get_hl(0, { name = "Debug" }),
            },
            {
                require("lazy.status").updates,
                cond = require("lazy.status").has_updates,
                color = vim.api.nvim_get_hl(0, { name = "Special" }),
            },
            {
                "diff",
                symbols = {
                    added    = icons.git.added,
                    modified = icons.git.modified,
                    removed  = icons.git.removed,
                },
                source = function()
                    local gitsigns = vim.b.gitsigns_status_dict
                    if gitsigns then
                        return {
                            added = gitsigns.added,
                            modified = gitsigns.changed,
                            removed = gitsigns.removed,
                        }
                    end
                end,
            },
            lualine_y = {
                { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
                { "location", padding = { left = 0, right = 1 } },
            },
            lualine_z = { function() return " " .. os.date("%R") end, },
        },
        extensions = { "neo-tree", "lazy" },
    },
    init = function()
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
            vim.o.statusline = " " -- set an empty statusline till lualine loads
        else
            vim.o.laststatus = 0   -- hide the statusline on the starter page
        end
    end,
}
