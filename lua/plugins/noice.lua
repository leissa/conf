return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim", -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "rcarriga/nvim-notify", -- OPTIONAL: only needed, if you want to use the notification view. If not available, we use `mini` as the fallback
        }
    }
}
