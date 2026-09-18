return {
    {
        "iamcco/markdown-preview.nvim",
        keys = {
            { "<leader>cp", false, ft = "markdown" },
            { "<localleader>p", ft = "markdown", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
        },
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        keys = {
            { "<leader>um", false, ft = "markdown" },
            { "<localleader>r", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown" },
        },
    },
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
