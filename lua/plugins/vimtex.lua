return {
    "lervag/vimtex",
    dependencies = {
        { -- which key integration
            "folke/which-key.nvim",
            optional = true,
            opts = {
                defaults = {
                    ["<localleader>l"] = { name = "+LaTeX" },
                },
            },
        },
    },
    init = function()
        vim.g.vimtex_view_general_viewer     = 'okular'
        vim.g.vimtex_view_general_options    = '--unique file:@pdf\\#src:@line@tex'
        vim.g.vimtex_quickfix_ignore_filters = {
            'Marginpar on page',
            'Overfull',
            'Underfull',
            'Missing ".*" in',
            'todonotes Warning',
            'Font shape.*',
            'cannot apply log',
        }
    end
}
