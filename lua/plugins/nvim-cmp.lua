return {
  "hrsh7th/nvim-cmp",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.preselect = cmp.PreselectMode.None
    opts.completion = {
      completeopt = "noselect",
    }
    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
    })
  end,
}
