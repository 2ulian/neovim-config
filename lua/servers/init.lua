local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = require("utils.lsp").on_attach

-- global default for all lsp
vim.lsp.config("*", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("nixd")
vim.lsp.enable("pyright")
vim.lsp.enable("efm")
vim.lsp.enable("bashls")
vim.lsp.enable("intelephense")
vim.lsp.enable("ts_ls")
-- vscode_lang_server
vim.lsp.enable("html")
vim.lsp.enable("cssls")
---------------------
