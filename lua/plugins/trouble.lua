return {
    "folke/trouble.nvim",
    branch = "dev",
    lazy = false,
    keys = {
        { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                            desc = "Trouble: Location List", },
        { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                             desc = "Trouble: Quickfix List", },
        { "<leader>xr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "Trouble: LSP Definitions / references / ...", },
        { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Trouble: Symbols", },
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Trouble: Diagnostics", },
        { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Trouble: Buffer Diagnostics", },
    },
    opts = {}
}
