return {
    "leissa/nvim-typst",
    opts = {
        compiler = {
            typst = {
                continuous = true, -- typst watch
                out_dir = "build",
            },
        },
    },
}
