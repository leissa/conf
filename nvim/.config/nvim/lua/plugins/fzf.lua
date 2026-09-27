return {
    "ibhagwan/fzf-lua",
    keys = {
        { "<C-p>", "<leader>ff", desc = "Find Files (Root Dir)", remap = true },
        { "<leader>sf", "<cmd>FzfLua<cr>", desc = "Find FzfLua Command" },
    },
    enabled = false,
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
