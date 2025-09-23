-- Réutilise tes presets efmls-configs
local luacheck = require("efmls-configs.linters.luacheck")
local stylua = require("efmls-configs.formatters.stylua")

local flake8 = require("efmls-configs.linters.flake8")
local black = require("efmls-configs.formatters.black")

local eslint = require("efmls-configs.linters.eslint")
local prettier = require("efmls-configs.formatters.prettier")

local fixjson = require("efmls-configs.formatters.fixjson") --json formatter

local alejandra = require("efmls-configs.formatters.alejandra") --nix formatter

local rustfmt = require("efmls-configs.formatters.rustfmt") -- rust formatter

return {
	filetypes = {
		"css",
		"docker",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"jsonc",
		"lua",
		"markdown",
		"python",
		"typescript",
		"typescriptreact",
		"nix",
		"php",
		"rust",
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
		hover = true,
		documentSymbol = true,
		codeAction = true,
		completion = true,
	},
	settings = {
		languages = {
			css = { prettier },
			docker = { prettier },
			html = { prettier },
			javascript = { eslint, prettier },
			javascriptreact = { eslint, prettier },
			json = { fixjson, eslint },
			jsonc = { fixjson, eslint },
			lua = { luacheck, stylua },
			markdown = { fixjson, eslint },
			python = { flake8, black },
			typescript = { eslint, prettier },
			typescriptreact = { eslint, prettier },
			nix = { alejandra },
			rust = { rustfmt },
			-- php = { ... } -- tu peux ajouter un formatter/linter si souhaité
		},
	},
}
