return {
    {
        "the-mayankjha/fk_markdown.nvim",
        ft = "markdown",
        keys = {
            { "<localleader>p", "<cmd>FkPreviewToggle<cr>", ft = "markdown", desc = "Markdown Preview" },
            { "<localleader>r", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown", desc = "Render Markdown" },
        },
        config = function()
            require("fk_markdown").setup({
                sign = { enabled = false },
                -- Without a `code` table, fk_markdown keeps left_pad = 0 but still draws its `│` border at
                -- col 0, covering the first char. Passing one makes it pad by 1. It would also force
                -- bg = #181825 here, so we hand back the colorscheme's own RenderMarkdownCode bg instead.
                code = { background = { color = "RenderMarkdownCode" } },
                latex ={ enabled = Snacks.image.config.math.enabled }, -- follows <leader>um (see keymaps.lua)
            })
        end,
    },
    -- fk_markdown replaces LazyVim's markdown preview + rendering (lang.markdown extra)
    { "iamcco/markdown-preview.nvim", enabled = false },
    { "MeanderingProgrammer/render-markdown.nvim", enabled = false },
    {
        "mfussenegger/nvim-lint",
        opts = function()
            -- nvim-lint pipes stdin, so markdownlint-cli2 only discovers configs relative to cwd.
            local cfg = vim.fn.expand("~/.config/markdownlint-cli2/.markdownlint-cli2.jsonc")
            local linter = require("lint").linters["markdownlint-cli2"]
            linter.args = { "--config", cfg, "-" }
        end,
    },
}
