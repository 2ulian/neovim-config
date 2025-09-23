local M = {}

function M.setup()
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	local workspace_dir = "/home/fellwin/java/" .. project_name

	-- KEYMAPPINGS ----------------------------------------------------------------
	local jdtls = require("jdtls")
	local function keymap(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = true, desc = desc })
	end

	-- Extract
	keymap("v", "<leader>ev", function()
		jdtls.extract_variable(true)
	end, "Extract Variable")
	keymap("n", "<leader>ev", jdtls.extract_variable, "Extract Variable (cursor)")
	keymap("v", "<leader>ec", function()
		jdtls.extract_constant(true)
	end, "Extract Constant")
	keymap("n", "<leader>ec", jdtls.extract_constant, "Extract Constant (cursor)")
	keymap("v", "<leader>em", function()
		jdtls.extract_method(true)
	end, "Extract Method")
	keymap("n", "<leader>em", jdtls.extract_method, "Extract Method (cursor)")
	-- For other keymaps, just use same as global LSP keymaps
	-------------------------------------------------------------------------------

	--------------------------------------------------------------------------
	-- Personnal adding for cmp
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- mappings
	local on_attach = require("utils.lsp").on_attach
	--------------------------------------------------------------------------

	local config = {
		-- The command that starts the language server
		-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
		cmd = { "jdtls", "-data", workspace_dir },
		-- 💀
		-- This is the default if not provided, you can remove it. Or adjust as needed.
		-- One dedicated LSP server & client will be started per unique root_dir
		root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

		--------------------------------------------------------------------------
		--- Personnal adding for cmp part2
		capabilities = capabilities,
		on_attach = on_attach,
		--------------------------------------------------------------------------

		-- Here you can configure eclipse.jdt.ls specific settings
		-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
		-- for a list of options
		settings = {
			java = {},
		},

		-- Language server `initializationOptions`
		-- You need to extend the `bundles` with paths to jar files
		-- if you want to use additional eclipse.jdt.ls plugins.
		--
		-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
		--
		-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
		init_options = {
			bundles = {},
		},
	}
	-- This starts a new client & server,
	-- or attaches to an existing client & server depending on the `root_dir`.
	require("jdtls").start_or_attach(config)
end

return M
