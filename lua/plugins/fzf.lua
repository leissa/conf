return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<leader><space>", false }, -- do not clash with hop
    { "<leader>,", false },       -- do not clash with sibling-swap
    { "<leader>:", false },       -- do not clash with sibling-swap
    { "<C-p>", "<leader>ff", desc = "Find Files (Root Dir)", remap = true },
    { "<leader>sf", "<cmd>FzfLua<cr>", desc = "Find FzfLua Command" },
    {
      "<leader>bs",
      "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
      desc = "Switch Buffer",
    },
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
