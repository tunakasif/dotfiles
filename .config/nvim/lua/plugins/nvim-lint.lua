return {
	"mfussenegger/nvim-lint",
	opts = function(_, opts)
		vim.api.nvim_create_user_command("LintInfo", function()
			local lint = require("lint")
			local ft = vim.bo.filetype
			local configured = lint.linters_by_ft[ft] or {}
			local running = lint.get_running(0)

			print("filetype: " .. ft)
			print("configured linters: " .. vim.inspect(configured))
			print("running linters: " .. vim.inspect(running))
		end, {})

		opts.linters_by_ft = vim.tbl_extend("force", opts.linters_by_ft or {}, {
			markdown = { "markdownlint-cli2" },
			nix = { "statix" },
			python = { "mypy" },
		})
	end,
}
