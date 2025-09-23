return {
	"barrett-ruth/live-server.nvim",
	port = 8080,
	browser_command = "",
	quiet = false,
	cmd = { "LiveServerStart" },
	config = true,
	args = {
		"-o", -- current folder
		"--ignore=**/favicon.ico", -- no favicon errors
	},
}
