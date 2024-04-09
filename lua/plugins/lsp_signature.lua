return {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
        local sig = require'lsp_signature'
        sig.setup(opts)
        sig.on_attach()
    end
}
