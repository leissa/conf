return {
    "neovim/nvim-lspconfig",
    opts = {},
    config = function()
        require'lspconfig'.tinymist.setup{}
    end,
}

