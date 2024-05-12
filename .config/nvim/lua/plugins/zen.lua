return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			options = {
				number = false,
				relativenumber = false,
			},
		},
		plugins = {
			options = {
				enabled = true,
				laststatus = 0, -- turn off the statusline in zen mode
			},
			tmux = { enabled = true },
		},
	},
}
