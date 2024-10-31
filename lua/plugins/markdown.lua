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
}
