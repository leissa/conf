return {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
        image = {
            math = {
                enabled = false,
            },
        },
    },
    keys = {
        { "<leader><space>", false }, -- do not clash with hop
        { "<leader>sC", false },
        { "<C-p>", "<leader>ff", desc = "Find Files (Root Dir)", remap = true },
        { "<leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },
        { "<leader>s:", function() Snacks.picker.command_history() end, desc = "Command History" },
    },
}
