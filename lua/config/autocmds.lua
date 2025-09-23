-- ================================================================================================
-- TITLE : auto-commands
-- ABOUT : automatically run code on defined events (e.g. save, yank)
-- ================================================================================================

-- Restore last cursor position when reopening a file
local last_cursor_group = vim.api.nvim_create_augroup("LastCursorGroup", {})
vim.api.nvim_create_autocmd("BufReadPost", {
	group = last_cursor_group,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Highlight the yanked text for 200ms
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_yank_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})

-- format on save using efm langserver and configured formatters
local lsp_fmt_group = vim.api.nvim_create_augroup("FormatOnSaveGroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	callback = function()
		local efm = vim.lsp.get_clients({ name = "efm" })
		if vim.tbl_isempty(efm) then
			return
		end
		vim.lsp.buf.format({ name = "efm", async = true })
	end,
})

-----------------------------------------------------------------------------------
-- Java: start jdtls when opening a Java file
vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		require("java.jdtls").setup()
	end,
})

-- Java: format on save using jdtls
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.java",
	callback = function(args)
		vim.lsp.buf.format({
			async = false,
			filter = function(client)
				return client.name == "jdtls"
			end,
		})
	end,
})

-- Java: relaunch test on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.java",
	callback = function()
		local neotest = require("neotest")
		neotest.run.run(vim.loop.cwd())
	end,
})

-- Java: add import on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.java",
	callback = function()
		vim.lsp.buf.code_action({
			context = { only = { "source.organizeImports" } },
			apply = true,
		})
	end,
})

-----------------------------------------------------------------------------------

-- php formatting on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.php", "*.phtml", "*.blade.php" },
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})
