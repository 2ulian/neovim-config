local util = require("lspconfig.util")

return function(capabilities, on_attach)
	local lspconfig = require("lspconfig")
	lspconfig.twiggy_language_server.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		-- cmd = { "twig-language-server", "--stdio" },
		filetypes = { "twig", "html.twig" },
		root_dir = function(fname)
			return util.find_git_ancestor(fname)
				or util.root_pattern("composer.json", "symfony.lock", ".git")(fname)
				or vim.fn.getcwd()
		end,
	})
end
