return {
    "ctrlpvim/ctrlp.vim",
    dependencies = { 'DavidEGx/ctrlp-smarttabs' },
    enabled = false,
    config = function()
        vim.g.ctrlp_extensions          = { 'smarttabs' }
        vim.g.ctrlp_custom_ignore       = {
            dir  = '\\v[\\/](\\.(git|hg|svn)|\\_site|build|modules|html|external)$',
            file = '\\v\\.(exe|so|dll|class|png|prg|jpg|jpeg|ll)$',
        }
        vim.g.ctrlp_open_multiple_files = 'ir'
        vim.g.ctrlp_regexp              = 1
        vim.g.ctrlp_open_new_file       = 'ir'
        -- vim.g.ctrlp_buffer_func = {
        --     enter = nil,
        --     exit = function()
        --         vim.cmd([[bd]])
        --     end,
        -- }
    end,
}
