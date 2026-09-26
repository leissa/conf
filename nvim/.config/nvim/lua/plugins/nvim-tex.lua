return {
    -- Local checkout at ~/projects/nvim-tex -- the VimTeX replacement.
    dir = vim.fn.expand("~/projects/nvim-tex"),
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
            },
        },

        -- Was `vim.g.vimtex_view_enabled = false`; nvim-tex's viewer + SyncTeX is
        -- the reason to switch, so it stays on.  Uncomment to go back to no viewer.
        -- view = { enabled = false },
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
