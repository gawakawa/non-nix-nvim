return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		vim.diagnostic.config({
			virtual_text = false,
			virtual_lines = {
				format = function(diagnostic)
					return string.format(
						"%s\n(%s: %s)",
						diagnostic.message,
						diagnostic.source or "?",
						diagnostic.code or "?"
					)
				end,
			},
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		local caps = require("cmp_nvim_lsp").default_capabilities()

		vim.lsp.config.ts_ls = { capabilities = caps }
		vim.lsp.config.basedpyright = { capabilities = caps }
		vim.lsp.config.ruff = {
			capabilities = caps,
			on_attach = function(client)
				-- delegate hover to basedpyright
				client.server_capabilities.hoverProvider = false
			end,
		}
		vim.lsp.config.terraformls = { capabilities = caps }
		vim.lsp.config.lua_ls = {
			capabilities = caps,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		}

		vim.lsp.enable({
			"ts_ls",
			"basedpyright",
			"ruff",
			"terraformls",
			"lua_ls",
		})
	end,
}
