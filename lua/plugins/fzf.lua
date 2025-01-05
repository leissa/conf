return {
    "ibhagwan/fzf-lua",
    opts = {
        grep = {
            rg_glob = true, -- default to glob parsing?
        },
        previewers = {
            builtin = {
                extensions = {
                    ["png"] = { "icat" },
                    ["jpg"] = { "icat" },
                },
            },
        },
    },
}
