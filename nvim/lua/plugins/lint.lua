return {
	"mfussenegger/nvim-lint",
	event = { "BufWritePost" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			terraform = { "tflint" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
