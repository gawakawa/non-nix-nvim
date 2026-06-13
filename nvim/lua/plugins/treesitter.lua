return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	event = "BufReadPre",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"bash",
				"json",
				"markdown",
				"typescript",
				"javascript",
				"tsx",
				"python",
				"terraform",
				"hcl",
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
