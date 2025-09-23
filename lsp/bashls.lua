return function(capabilities, on_attach)
	local lspconfig = require("lspconfig")
	lspconfig.bashls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "sh", "bash", "zsh" },
	})
end
