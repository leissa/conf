return {
    'leissa/nvim-tex',
    -- dir = vim.fn.expand("~/projects/nvim-tex"),
    name = "nvim-tex",
    ft = { "tex", "plaintex", "latex" },
    opts = {
        -- Ported from the old vimtex spec: vimtex's quickfix ignore filters.
        -- These are Lua patterns here, not Vim regexes.
        qf = {
            ignore_filters = {
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
                "Columns might not be balanced",
                "Some images may lack description",
                "ACM keywords are mandatory",
                "ACM reference format is mandatory",
                "CCS concepts are mandatory",
                "empty address in",
                "empty publisher in",
                "page numbers missing",
                "empty school",
            },
        },
        imaps = { leader = 'ö' },
    },

    -- Was in the vimtex spec to kill vimtex's indentexpr.  nvim-tex ships no
    -- indentation at all, so nvim's built-in tex indent applies again.
    -- Uncomment if that indent gets in the way.
    -- init = function()
    --     vim.api.nvim_create_autocmd("FileType", {
    --         pattern = "tex",
    --         command = "set indentexpr=",
    --     })
    -- end,
}
