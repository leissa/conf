return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            -- LazyVim's tex extra ships no formatter, so a tex buffer can only ever fall back
            -- to texlab's LSP formatting -- and warns "No formatter available" whenever texlab
            -- isn't (yet) attached. tex-fmt also covers .cls/.sty, which are filetype `tex`.
            -- Commented out with the vimtex -> nvim-tex switch: nvim-tex points
            -- texlab at latexindent, so tex buffers format via the LSP again.
            -- tex = { "tex-fmt" },
            -- plaintex = { "tex-fmt" },
            -- The typst extra prefers tinymist's LSP formatting, which can't do
            -- --wrap-text=sentence, so run the typstyle CLI instead.
            typst = { "typstyle", lsp_format = "fallback" },
        },
        formatters = {
            -- 4-space indent, one sentence per line, no column limit
            typstyle = { prepend_args = { "-t", "4", "-l", "10000", "--wrap-text=sentence" } },
        },
    },
}
