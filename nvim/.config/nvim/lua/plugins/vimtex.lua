return {
    "lervag/vimtex",
    lazy = false, -- lazy-loading will disable inverse search
    keys = {
        { "<localleader>l", ft = "tex", "<cmd>VimtexCompile<cr>", desc = "vimtex-compile)" },
    },
    config = function()
        vim.g.vimtex_mappings_prefix = "<localleader>"
        vim.g.vimtex_view_enabled = false
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "tex",
            command = "set indentexpr=",
        })

        vim.g.vimtex_syntax_enabled = 0
        vim.g.vimtex_syntax_conceal_disable = 1

        vim.g.vimtex_quickfix_ignore_filters = {
            "\\vspace should only be used",
            "A possible image without description",
            "Marginpar on page",
            "Overfull",
            "Underfull",
            'Missing ".*" in',
            "todonotes Warning",
            "Font shape.*",
            "cannot apply log",
            "in font nullfont",
            "Size substitutions",
            "Some font shapes",
        }
    end,
}
