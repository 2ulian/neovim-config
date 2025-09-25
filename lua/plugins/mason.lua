return {
	{
		"williamboman/mason.nvim",
		opts = {
			log_level = vim.log.levels.DEBUG,
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✅",
					package_pending = "⏳",
					package_uninstalled = "❌",
				},
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"pyright",
				"typescript-language-server",
			},
			automatic_installation = true,
		},
		{
			"jay-babu/mason-null-ls.nvim",
			dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
			opts = {
				ensure_installed = {
					"stylua",
					"prettier",
					"eslint",
					"luacheck",
					"black",
					"flake8",
					"fixjson",
					"alejandra",
				},
				automatic_installation = true,
			},
		},
	},
}
