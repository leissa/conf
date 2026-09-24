return {
    {
        "leissa/compile.nvim", -- fork of pohlrabi404/compile.nvim
        -- This event makes sure the plugin loads lazily. You can
        -- use any event you like, such as `ft` for file types or `autocmds`.
        event = "VeryLazy",
        -- don't forget the options table!
        opts = {
            cmds = {
                -- The default command to run when you compile. Change this if you use a different build tool!
                -- I will make it possible to have dynamic default for each project types soon~
                default = "make -k -j16",
            },
            patterns = {
                -- The default Makefile pattern matches make's own "*** [build.make:401: foo.o] Error 1"
                -- lines, which with CMake always point into the generated build.make.
                -- Shadow it with the plain file:row:col pattern (duplicates get deduplicated).
                Makefile = { "(%S+%.%a+):(%d+):(%d+)", "123" },
            },
            -- Save all buffers before (re)compiling, like 'autowrite' does for :make
            keys = {
                global = { n = { ["<localleader>cc"] = "vim.cmd('silent! wall') require('compile').compile()" } },
                term = { buffer = { n = { c = "vim.cmd('silent! wall') require('compile').compile()" } } },
            },
        },
    },
    -- compile.nvim sets its keymaps without desc; label them for which-key
    {
        "folke/which-key.nvim",
        opts = {
            spec = {
                { "<localleader>c", group = "compile" },
                { "<localleader>cc", desc = "Compile / recompile" },
                { "<localleader>cn", desc = "Next error" },
                { "<localleader>cp", desc = "Previous error" },
                { "<localleader>cf", desc = "First error" },
                { "<localleader>cl", desc = "Last error" },
                { "<localleader>cj", desc = "Jump to compile terminal" },
                { "<localleader>cr", desc = "Clear compile terminal" },
                { "<localleader>cq", desc = "Close compile terminal" },
            },
        },
    },
}
