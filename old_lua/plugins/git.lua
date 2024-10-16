return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "ibhagwan/fzf-lua",
        {
            "sindrets/diffview.nvim",
            opts = {
                keymaps = {
                    disable_defaults = true,
                },
            },
        },
    },
    config = true
}
