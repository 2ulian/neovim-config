local function vue_ts_plugin_path()
	local root = vim.fs.root(0, { "package.json", "tsconfig.json", "jsconfig.json", ".git" }) or vim.loop.cwd()
	local p = root .. "/node_modules/@vue/typescript-plugin"
	return (vim.fn.isdirectory(p) == 1) and p or nil
end

local plugin_loc = vue_ts_plugin_path()

return {
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },

	init_options = (plugin_loc and {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = plugin_loc,
				languages = { "javascript", "typescript", "vue" },
			},
		},
	} or nil),

	settings = {
		typescript = { inlayHints = { indentStyle = "space", indentSize = 2 } },
		javascript = { inlayHints = { indentStyle = "space", indentSize = 2 } },
	},
}
