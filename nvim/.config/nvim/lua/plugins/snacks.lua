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
        { "<leader>n", false },       -- noice history instead (see noice.lua)
        { "<leader>sC", false },
        { "<leader>sR", false },      -- do not clash with grug-far
        { "<leader>sr", function() Snacks.picker.resume() end, desc = "Resume" },
        { "<C-p>", "<leader>ff", desc = "Find Files (Root Dir)", remap = true },
        { "<leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },
        { "<leader>s:", function() Snacks.picker.command_history() end, desc = "Command History" },
    },
}
