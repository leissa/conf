return {
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
    },
}
