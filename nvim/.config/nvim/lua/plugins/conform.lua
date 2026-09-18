return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            -- LazyVim's tex extra ships no formatter, so a tex buffer can only ever fall back
            -- to texlab's LSP formatting -- and warns "No formatter available" whenever texlab
            -- isn't (yet) attached. tex-fmt also covers .cls/.sty, which are filetype `tex`.
            tex = { "tex-fmt" },
            plaintex = { "tex-fmt" },
        },
    },
}
