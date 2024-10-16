return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            spec = {
                { "<leader>i", group = "iswap", icon = "↔" },
                { "<leader><leader>", group = "hop" },
                { "<leader>N", group = "notify" },
                { "<leader>b", group = "buffer" },
                { "<leader>c", group = "code" },
                { "<leader>d", group = "debug" },
                { "<leader>g", group = "git" },
                { "<leader>l", group = "LSP", icon = "󰆧" },
                { "<leader>n", group = "noice" },
                { "<leader>q", group = "quit/session" },
                { "<leader>s", group = "search" },
                { "<leader>t", group = "tags" },
                { "<leader>u", group = "ui" },
                { "<leader>w", group = "windows" },
                { "<leader>x", group = "diagnostics/quickfix" },
                { "<localleader>l", group = "LaTeX", icon = "" },
                { "[", group = "prev" },
                { "]", group = "next" },
                { "g", group = "goto" },
                { "gz", group = "surround", mode = { "n", "v" }, },
                { "z", group = "fold" },
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
}
