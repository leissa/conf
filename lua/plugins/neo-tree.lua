return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            'MunifTanjim/nui.nvim',
            'nvim-lua/plenary.nvim',
        },
        lazy = false, -- use neo-tree instead of netrw
        keys = {
            { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
        },
        config = function()
            require("neo-tree").setup()
        end,
    },
}
