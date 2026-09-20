return {
    "nvim-treesitter",
    opts = {
        ignore_install = { "latex" },
        ensure_installed = { "mim" },
    },
    init = function()
        -- Mim, the front-end language of MimIR.  The grammar is not (yet) in nvim-treesitter's
        -- parser list, so register the local checkout: `queries` is symlinked into the parser
        -- install dir, i.e. editing the .scm files there takes effect right away.
        vim.filetype.add({ extension = { mim = "mim" } })
        vim.api.nvim_create_autocmd("User", {
            pattern = "TSUpdate",
            callback = function()
                require("nvim-treesitter.parsers").mim = {
                    install_info = {
                        path = vim.fn.expand("~/mimir/tree-sitter-mim"),
                        queries = "queries",
                        generate = false,
                        generate_from_json = false,
                    },
                }
            end,
        })
    end,
}
