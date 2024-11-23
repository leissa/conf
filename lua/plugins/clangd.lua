return {
  "p00f/clangd_extensions.nvim",
  keys = {
    { "<leader>ch", false },
    { "<localleader>i", "<cmd>ClangdToggleInlayHints<cr>",   ft = {"c", "cpp"}, desc = "Toggle Inlay Hints (C/C++)" },
    { "<localleader>t", "<cmd>ClangdTypeHierarchy<cr>",      ft = {"c", "cpp"}, desc = "Type Hierarchy (C/C++)" },
    { "<localleader>h", "<cmd>ClangdSwitchSourceHeader<cr>", ft = {"c", "cpp"}, desc = "Switch Source/Header (C/C++)" },
  },
  opts = {
    inlay_hints = {
      -- inline = false,
      parameter_hints_prefix = "← ",
      other_hints_prefix = "⇨ ",
    },
  },
}
