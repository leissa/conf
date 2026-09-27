return {
    { "folke/todo-comments.nvim", version = "*" },
    {
        "folke/noice.nvim",
        opts = {
            -- messages = {
            --     enabled = false,
            -- },
        },
        keys = {
            -- one place for everything: noice history is a superset of the snacks notification history
            { "<leader>n", function() require("noice").cmd("history") end, desc = "Message History (Noice)" },
        },
    },
}
