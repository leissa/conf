return {
    "ibhagwan/fzf-lua",
    keys = {
        { "<leader><space>", false }, -- do not clash with hop
        { "<C-p>", "<leader>ff", desc = "Find Files (Root Dir)", remap = true },
        { "<leader>sf", "<cmd>FzfLua<cr>", desc = "Find FzfLua Command" },
    },
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
