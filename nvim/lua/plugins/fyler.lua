return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "echasnovski/mini.nvim" },
	lazy = false,
	keys = {
		{ "<leader>e", "<cmd>Fyler<CR>", desc = "Open Fyler" },
	},
	config = function()
		require("mini.icons").setup()
		require("fyler").setup({
			views = {
				finder = {
					win = {
						kind = "split_right_most",
					},
				},
			},
		})
	end,
}
