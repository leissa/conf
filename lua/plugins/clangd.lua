return {
  "p00f/clangd_extensions.nvim",
  keys = {
    { "<leader>ci", "<cmd>ClangdToggleInlayHints<cr>", desc = "Toggle Inlay Hints (C/C++)" },
    { "<leader>ct", "<cmd>ClangdTypeHierarchy<cr>", desc = "Type Hierarchy (C/C++)" },
  },
  opts = {
    inlay_hints = {
      -- inline = false,
      parameter_hints_prefix = "← ",
      other_hints_prefix = "⇨ ",
    },
  },
}
