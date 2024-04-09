return {
    'sakhnik/nvim-gdb',
    ft = { 'c', 'cpp' },
    lazy = false,
    init = function() vim.g.nvimgdb_disable_start_keymaps = true end,
    config = function()
        vim.g.nvimgdb_disable_start_keymaps = true
        local nvimgdb = require 'nvimgdb'
        nvimgdb.setup()

        vim.g.nvimgdb_config = {
            set_tkeymaps = function()
                nvimgdb.here.keymaps:set_t()
                local buf  = vim.api.nvim_get_current_buf()
                local opts = { nowait = true }
                vim.api.nvim_buf_set_keymap(buf, 'n', 'r', '<cmd>GdbRun<cr>', opts)
                vim.api.nvim_buf_set_keymap(buf, 'n', 's', '<cmd>GdbStep<cr>', opts)
                vim.api.nvim_buf_set_keymap(buf, 'n', 'c', '<cmd>GdbContinue<cr>', opts)
                vim.api.nvim_buf_set_keymap(buf, 'n', 'x', '<cmd>GdbNext<cr>', opts)
                vim.api.nvim_buf_set_keymap(buf, 'n', 'l', '<cmd>GdbUntil<cr>', opts)
                vim.api.nvim_buf_set_keymap(buf, 'n', 'f', '<cmd>GdbFinish<cr>', opts)
                vim.api.nvim_buf_set_keymap(buf, 'n', 'u', '<cmd>GdbFrameUp<cr>', opts)
                vim.api.nvim_buf_set_keymap(buf, 'n', 'd', '<cmd>GdbFrameDown<cr>', opts)
                vim.api.nvim_buf_set_keymap(buf, 'n', '<c-p>', '<c-w><c-w><c-p>', opts)
            end,
        }
    end,
    keys = {
        { '<leader>bb', '<cmd>GdbBreakpointToggle<cr>', desc = "gdb: toggle breakpoint" },
        { 'gdb',        ':GdbStart gdb -q --args ',     desc = "gdb: start" },
    }
}
