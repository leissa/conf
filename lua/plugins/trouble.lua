return {
    "folke/trouble.nvim",
    branch = "dev",
    lazy = false,
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Trouble: Diagnostics", },
        { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Trouble: Buffer Diagnostics", },
        { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                            desc = "Trouble: Location List", },
        { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                             desc = "Trouble: Quickfix List", },
        { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Trouble: Symbols", },
        { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "Trouble: LSP Definitions / references / ...", },
    },
    opts = {}
}
