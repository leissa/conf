return {
    { "andweeb/presence.nvim", config = true },
    { "AnyDSL/vim-mim" },
    { "sindrets/diffview.nvim" },
    -- { "machakann/vim-swap"},
    {
        "mizlan/iswap.nvim",
        event = "VeryLazy",
        keys = {
            { "gS", "<cmd>ISwap<cr>", desc = "ISwap" },
            { "gs", "<cmd>ISwapWith<cr>", desc = "ISwapWith" },
        },
    },
}
