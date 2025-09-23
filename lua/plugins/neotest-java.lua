return {
	{
		"rcasia/neotest-java",
		ft = "java",
		dependencies = {
			"mfussenegger/nvim-jdtls",
			"mfussenegger/nvim-dap", -- for the debugger
			"rcarriga/nvim-dap-ui", -- recommended
			"theHamsta/nvim-dap-virtual-text", -- recommended
		},
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			local neotest = require("neotest")

			-- detect if the summary window is open
			local function is_summary_open()
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					if vim.bo[buf].filetype == "neotest-summary" then
						return true
					end
				end
				return false
			end

			-- run tests in the current file and show the summary if not already open
			local function run_file_and_show_summary()
				neotest.run.run(vim.fn.expand("%"))
				if not is_summary_open() then
					neotest.summary.toggle()
				end
			end

			-- run all tests in the project and show the summary if not already open
			local function run_project_and_show_summary()
				neotest.run.run(vim.loop.cwd())
				if not is_summary_open() then
					neotest.summary.toggle()
				end
			end

			-- setup neotest with Java adapter
			neotest.setup({
				adapters = {
					require("neotest-java")({
						-- config here
					}),
				},
			})

			-- mapping
			vim.keymap.set("n", "<leader>tt", run_file_and_show_summary, { desc = "Run tests in file" })
			vim.keymap.set("n", "<leader>ta", run_project_and_show_summary, { desc = "Run all project tests" })
		end,
	},
}
