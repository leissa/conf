return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim", -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        {
            "rcarriga/nvim-notify",
            keys = {
                { "<leader>Nd", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "Notify: Dismiss", },
                { "<leader>Nh", "<cmd>Notifications<cr>",                                                    desc = "Notify: Histroy" },
            },
            opts = {
                stages = "static",
                timeout = 3000,
                max_height = function()
                    return math.floor(vim.o.lines * 0.75)
                end,
                max_width = function()
                    return math.floor(vim.o.columns * 0.75)
                end,
                on_open = function(win)
                    vim.api.nvim_win_set_config(win, { zindex = 100 })
                end,
            },
            init = function()
                vim.notify = require("notify")
            end,
        },
    },
    opts = {
        cmdline = {
            view = "cmdline",
        },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        routes = {
            {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "%d+L, %d+B" },
                        { find = "; after #%d+" },
                        { find = "; before #%d+" },
                    },
                },
                view = "mini",
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = true,
        },
        messages = {
            view_search = false,
        },
    },
    -- stylua: ignore
    keys = {
        { "<S-Enter>",  function() require("noice").redirect(vim.fn.getcmdline()) end,                 mode = "c",                  desc = "Redirect Cmdline" },
        { "<leader>na", function() require("noice").cmd("all") end,                                    desc = "Noice: All" },
        { "<leader>nd", function() require("noice").cmd("dismiss") end,                                desc = "Noice: Dismiss All" },
        { "<leader>nh", function() require("noice").cmd("history") end,                                desc = "Noice: History" },
        { "<leader>nl", function() require("noice").cmd("last") end,                                   desc = "Noice: Last Message" },
        { "<c-f>",      function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  silent = true,               expr = true,              desc = "Scroll Forward",  mode = { "i", "n", "s" } },
        { "<c-b>",      function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,               expr = true,              desc = "Scroll Backward", mode = { "i", "n", "s" } },
    },
}
