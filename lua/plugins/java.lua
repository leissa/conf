return {
	{
		"mfussenegger/nvim-jdtls",
		opts = {
			root_dir = function()
				vim.fs.root(0, { "pom.xml", "build.xml", "mvnw", "gradlew", ".git" })
			end,
		},
	},
}
