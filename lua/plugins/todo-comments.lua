-- Finds and lists all of the TODO, HACK, BUG, etc comment in your project and loads them into a browsable list.
return {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    -- event = "LazyFile",
    config = true,
    -- stylua: ignore
    keys = {
        { "]t",         function() require("todo-comments").jump_next() end,                      desc = "Next Todo Comment" },
        { "[t",         function() require("todo-comments").jump_prev() end,                      desc = "Previous Todo Comment" },
        { "<leader>xt", "<cmd>TodoTrouble<cr>",                                                   desc = "Todo (Trouble)" },
        { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",                           desc = "Todo/Fix/Fixme (Trouble)" },
        {
            "<leader>xs",
            function() require('fzf-lua').grep({ search = 'TODO|HACK|PERF|NOTE|FIX', no_esc = true }) end,
            desc = "Search Todo Comments"
        },
    },
}
