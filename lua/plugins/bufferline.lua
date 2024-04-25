return {
    {
        "akinsho/bufferline.nvim",
        version = "v4.5.3",
        lazy = false,
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle Pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
            { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>",          desc = "Delete Other Buffers" },
            { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete Buffers to the Right" },
            { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete Buffers to the Left" },
            { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
            { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
            { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
            { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
        },
        opts = {
            options = {
                close_command         = function(n) require("mini.bufremove").delete(n, false) end,
                right_mouse_command   = function(n) require("mini.bufremove").delete(n, false) end,
                diagnostics           = "nvim_lsp",
                diagnostics_indicator = function(_, _, diag)
                    local dicons = require("icons").diagnostics
                    local ret    = (diag.error and dicons.Error .. diag.error .. " " or "") ..
                    (diag.warning and dicons.Warn .. diag.warning or "")
                    return vim.trim(ret)
                end,
                offsets               = {
                    {
                        filetype   = "neo-tree",
                        text       = "Neo-tree",
                        highlight  = "Directory",
                        text_align = "left",
                    },
                },
            },
        },
    },
    {
        "echasnovski/mini.bufremove",
        keys = {
            {
                "<leader>bd",
                function()
                    local bd = require("mini.bufremove").delete
                    if vim.bo.modified then
                        local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()),
                            "&Yes\n&No\n&Cancel")
                        if choice == 1 then -- Yes
                            vim.cmd.write()
                            bd(0)
                        elseif choice == 2 then -- No
                            bd(0, true)
                        end
                    else
                        bd(0)
                    end
                end,
                desc = "Delete Buffer",
            },
            { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
        },
    },
}
