return {
  "folke/noice.nvim",
  keys = {
    -- stylua: ignore
    { "<leader>sn", "", false},
    { "<leader>snl", false},
    { "<leader>snh", false},
    { "<leader>sna", false},
    { "<leader>snd", false},
    { "<leader>snt", false},
    { "<leader>n", "", desc = "+noice"},
    { "<leader>nl", function() require("noice").cmd("last")    end, desc = "Noice Last Message" },
    { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>na", function() require("noice").cmd("all")     end, desc = "Noice All" },
    { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<leader>nt", function() require("noice").cmd("pick")    end, desc = "Noice Picker (Telescope/FzfLua)" },
  },
  opts = {
    cmdline = {
      format = {
        conceal = false,
      },
    },
    presets = {
      long_message_to_split = false,
    },
    redirect = false,
      -- view = "popup",
      -- filter = { event = "msg_show" },
    -- },
  }
}
