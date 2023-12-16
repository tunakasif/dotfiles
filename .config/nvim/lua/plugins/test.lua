return {
	{ "nvim-neotest/neotest-plenary" },
	{ "rouge8/neotest-rust" },
	{
		"nvim-neotest/neotest",
		opts = {
			adapters = {
				["neotest-rust"] = {
					args = { "--no-capture" },
				},
			},
			status = { virtual_text = true },
			output = { open_on_run = true },
			quickfix = {
				open = function()
					if require("lazyvim.util").has("trouble.nvim") then
						require("trouble").open({ mode = "quickfix", focus = false })
					else
						vim.cmd("copen")
					end
				end,
			},
		},
        -- stylua: ignore
        keys = {
            { "<leader>tt", false },
            { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
            { "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
            { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
            { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
            { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
            { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
            { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
        },
	},
}
