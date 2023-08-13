return {
	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			-- add a keymap to browse plugin files
			{
				"<leader>fp",
				function()
					require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
				end,
				desc = "Find Plugin File",
			},
		},
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				file_ignore_patterns = { ".git", "node_modules", "gspbox", "ltfat" },
				defaults = {
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
						},
					},
				},
			})
		end,
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
