local util = require("lazyvim.util")

return {
	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{
				"<leader><leader>",
				util.pick("files", { hidden = true, no_ignore = false }),
				desc = "Find files (root dir)",
			},
			{
				"<leader>ff",
				util.pick("files", { hidden = true, no_ignore = false }),
				desc = "Find files (root dir)",
			},
		},
		opts = {
			defaults = {
				file_ignore_patterns = { ".git/", "node_modules", "gspbox/", "ltfat/" },
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
				mappings = {
					i = {
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
					},
				},
			},
		},
	},
	-- {
	-- 	"telescope.nvim",
	-- 	dependencies = {
	-- 		"nvim-telescope/telescope-fzf-native.nvim",
	-- 		build = "make",
	-- 		config = function()
	-- 			require("telescope").load_extension("fzf")
	-- 		end,
	-- 	},
	-- },
}
