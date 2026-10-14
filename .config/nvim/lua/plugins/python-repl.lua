return {
	{
		"3rd/image.nvim",
		opts = {
			backend = "kitty",
			processor = "magick_cli",
			integrations = {},
			max_width = 100,
			max_height = 12,
			max_height_window_percentage = math.huge,
			max_width_window_percentage = math.huge,
			window_overlap_clear_enabled = true,
		},
	},
	{
		"benlubas/molten-nvim",
		version = "^1.0.0",
		lazy = false,
		build = ":UpdateRemotePlugins",
		dependencies = { "3rd/image.nvim" },
		init = function()
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_virt_text_output = true
			vim.g.molten_auto_open_output = false
			vim.g.molten_output_win_max_height = 20
		end,
		keys = {
			{ "<leader>ki", "<cmd>MoltenInit<cr>", desc = "Initialize kernel" },
			{ "<leader>kl", "<cmd>MoltenEvaluateLine<cr>", desc = "Run line" },
			{ "<leader>kR", "<cmd>MoltenRestart<cr>", desc = "Restart kernel" },
			{ "<leader>ko", "<cmd>noautocmd MoltenEnterOutput<cr>", desc = "Open output" },
			{ "<leader>kd", "<cmd>MoltenDelete<cr>", desc = "Clear cell output" },
			{ "<leader>kD", "<cmd>MoltenDelete!<cr>", desc = "Clear all outputs" },
			{
				"<leader>ks",
				":<C-u>MoltenEvaluateVisual<cr>gv",
				mode = "v",
				desc = "Run selection",
			},
		},
	},
	{
		"GCBallesteros/NotebookNavigator.nvim",
		ft = "python",
		dependencies = { "benlubas/molten-nvim" },
		config = function()
			require("notebook-navigator").setup({
				repl_provider = "molten",
				syntax_highlight = true,
			})
		end,
		keys = {
			{
				"<leader>kc",
				function()
					require("notebook-navigator").run_cell()
				end,
				desc = "Run cell",
			},
			{
				"<leader>kn",
				function()
					require("notebook-navigator").run_and_move()
				end,
				desc = "Run cell and move",
			},
			{
				"<leader>ka",
				function()
					require("notebook-navigator").run_all_cells()
				end,
				desc = "Run all cells",
			},
			{
				"]h",
				function()
					require("notebook-navigator").move_cell("d")
				end,
				desc = "Next cell",
			},
			{
				"[h",
				function()
					require("notebook-navigator").move_cell("u")
				end,
				desc = "Previous cell",
			},
		},
	},
}
