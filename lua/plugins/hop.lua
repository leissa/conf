return {
    {
        "smoka7/hop.nvim",
        config = true,
        enabled = false,
        keys = {
            { "<leader><leader>l", "<cmd>HopLine<cr>", silent = true, mode = { "n", "v" }, desc = "Line" },
            { "<leader><leader>c", "<cmd>HopChar1<cr>", silent = true, mode = { "n", "v" }, desc = "1 Char" },
            { "<leader><leader>C", "<cmd>HopChar2<cr>", silent = true, mode = { "n", "v" }, desc = "2 Chars" },
            { "<leader><leader>w", "<cmd>HopWord<cr>", silent = true, mode = { "n", "v" }, desc = "Word" },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            spec = {
                { "<leader><leader>", group = "hop" },
            },
        },
    },
}
