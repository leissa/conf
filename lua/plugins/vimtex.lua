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
	end,
}
