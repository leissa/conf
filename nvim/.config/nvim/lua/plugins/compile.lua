return {
    {
        "pohlrabi404/compile.nvim",
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
        },
        config = function(_, opts)
            local compile = require("compile")
            compile.setup(opts)
            -- compile.nvim maps its terminal-global keys (<localleader>cr/cq) on the terminal's
            -- BufCreate, but renaming that buffer fires BufDelete, whose cleanup removes them right
            -- away (and would also remove our own mappings with the same lhs). Drop them and map them
            -- ourselves below. Both callbacks read this table lazily, so emptying it after setup works.
            compile.opts.keys.term.global = {}
        end,
        keys = {
            {
                "<localleader>cr",
                function()
                    -- clear() would open an empty terminal if there is none
                    local compile = require("compile")
                    if vim.api.nvim_buf_is_valid(compile.term.state.buf) then compile.clear() end
                end,
                desc = "Clear compile terminal",
            },
            { "<localleader>cq", function() require("compile").destroy() end, desc = "Close compile terminal" },
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
            },
        },
    },
}
