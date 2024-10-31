return {
  "p00f/clangd_extensions.nvim",
  keys = {
    { "<leader>ch", false },
    { "<localleader>i", ft = {"c", "cpp"}, "<cmd>ClangdToggleInlayHints<cr>", desc = "Toggle Inlay Hints (C/C++)" },
    { "<localleader>t", ft = {"c", "cpp"}, "<cmd>ClangdTypeHierarchy<cr>", desc = "Type Hierarchy (C/C++)" },
    { "<localleader>h", ft = {"c", "cpp"}, "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
  },
  opts = {
    inlay_hints = {
      -- inline = false,
      parameter_hints_prefix = "← ",
      other_hints_prefix = "⇨ ",
    },
  },
}
