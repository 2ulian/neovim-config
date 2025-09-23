return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"creativenull/efmls-configs-nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "mason-org/mason.nvim", opts = {} },
	},
	config = function()
		require("utils.diagnostics").setup()
		require("servers")
	end,
}
