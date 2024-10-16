return {
  "smoka7/hop.nvim",
  config = true,
  keys = {
    { "<leader><leader>l", "<cmd>HopLine<cr>", silent = true, mode = { "n", "v" }, desc = "Line" },
    { "<leader><leader>c", "<cmd>HopChar1<cr>", silent = true, mode = { "n", "v" }, desc = "1 Char" },
    { "<leader><leader>C", "<cmd>HopChar2<cr>", silent = true, mode = { "n", "v" }, desc = "2 Chars" },
    { "<leader><leader>w", "<cmd>HopWord<cr>", silent = true, mode = { "n", "v" }, desc = "Word" },
  },
}
