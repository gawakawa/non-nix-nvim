return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"pyright",
					"ruff",
					"terraformls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- Wire cmp capabilities to all LSP servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
			if ok then
				capabilities = cmp_lsp.default_capabilities(capabilities)
			end
			vim.lsp.config("*", { capabilities = capabilities })

			-- Configure diagnostics display
			vim.diagnostic.config({
				virtual_text = false,
				virtual_lines = {
					format = function(diagnostic)
						return string.format("%s\n(%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
					end,
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- LSP server configs (new vim.lsp.config API, Neovim 0.11+)
			vim.lsp.config.lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			}
			vim.lsp.config.ts_ls = {}
			vim.lsp.config.pyright = {}
			vim.lsp.config.ruff = {}
			vim.lsp.config.terraformls = {}

			vim.lsp.enable({
				"lua_ls",
				"ts_ls",
				"pyright",
				"ruff",
				"terraformls",
			})
		end,
	},
}
