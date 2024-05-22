local util = require("lazyvim.util")

return {
	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{
				"<leader><leader>",
				util.telescope("files", { hidden = true, no_ignore = false }),
				desc = "Find files (root dir)",
			},
			{
				"<leader>ff",
				util.telescope("files", { hidden = true, no_ignore = false }),
				desc = "Find files (root dir)",
			},
			{
				"<leader>fF",
				util.telescope("files", { cwd = false, hidden = true, no_ignore = false }),
				desc = "Find files (cwd)",
			},
			{
				"<leader>fp",
				function()
					require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
				end,
				desc = "Find Plugin File",
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
	{
		"telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
	},
}
