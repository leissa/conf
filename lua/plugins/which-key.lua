  return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        plugins = { spelling = true },
        defaults = {
            mode = { "n", "v" },
            ["g"] = { name = "+goto" },
            ["gz"] = { name = "+surround" },
            ["z"] = { name = "+fold" },
            ["]"] = { name = "+next" },
            ["["] = { name = "+prev" },
            ["<leader><leader>"] = { name = "+hop" },
            ["<leader>b"] = { name = "+buffer" },
            ["<leader>c"] = { name = "+code" },
            ["<leader>f"] = { name = "+file/find" },
            ["<leader>g"] = { name = "+git" },
            ["<leader>l"] = { name = "+LSP" },
            ["<leader>n"] = { name = "+noice" },
            ["<leader>N"] = { name = "+notify" },
            ["<leader>q"] = { name = "+quit/session" },
            ["<leader>s"] = { name = "+search" },
            ["<leader>t"] = { name = "+tags" },
            ["<leader>u"] = { name = "+ui" },
            ["<leader>w"] = { name = "+windows" },
            ["<leader>x"] = { name = "+diagnostics/quickfix" },
        },
    },
--     init = function()
--         vim.o.timeout = true
--         vim.o.timeoutlen = 500
--     end,
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        wk.register(opts.defaults)
    end,
  }
