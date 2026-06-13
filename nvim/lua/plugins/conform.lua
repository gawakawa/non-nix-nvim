return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				python = { "ruff_format", "ruff_organize_imports" },
				terraform = { "terraform_fmt" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = function(_bufnr)
				return {
					timeout_ms = 3000,
				}
			end,
		})
	end,
}
