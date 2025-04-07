return {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
    keys = {
        -- stylua: ignore start
        { "<leader>xq", function() require("quicker").toggle()                   end, desc = "Toggle quickfix", },
        { "<leader>xl", function() require("quicker").toggle({ loclist = true }) end, desc = "Toggle loclist",  },
        { "<leader>x>", function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end, desc = "Expand quickfix context", },
        { "<leader>x<", function() require("quicker").collapse() end,                                                desc = "Collapse quickfix context" },
        -- stylua: ignore end
    },
}
