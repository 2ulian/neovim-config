return {
	url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
	ft = { "java" },
	dependencies = { "neovim/nvim-lspconfig" },
	config = function()
		local sonarlint = require("sonarlint")
		local ANALYZERS_DIR = "/nix/store/09hgay7llgbqrfvi4nxm3n11c9vp7vr8-sonarlint-ls-3.25.0.76263/share/plugins"
		local jars = vim.fn.globpath(ANALYZERS_DIR, "*.jar", false, true)

		local cmd = { "sonarlint-ls", "-stdio" }
		if #jars > 0 then
			table.insert(cmd, "-analyzers")
			vim.list_extend(cmd, jars) -- chemins ABSOLUS
		end

		-- handler nécessaire (au cas où)
		vim.lsp.handlers["sonarlint/isOpenInEditor"] = function(_, params, _)
			local uri = (params and (params.uri or (params.textDocument and params.textDocument.uri))) or ""
			if uri == "" then
				return false
			end
			local bufnr = vim.uri_to_bufnr(uri)
			if not vim.api.nvim_buf_is_loaded(bufnr) then
				return false
			end
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				if vim.api.nvim_win_get_buf(win) == bufnr then
					return true
				end
			end
			return false
		end

		sonarlint.setup({
			server = { cmd = cmd },
			filetypes = { "java" },
		})

		--vim.schedule(function()
		--	print("[sonarlint cmd] " .. table.concat(cmd, " "))
		--end)
	end,
}
