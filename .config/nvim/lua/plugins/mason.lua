local mason_packages = {
	"clangd",
	"cmakelang",
	"cmakelint",
	"codelldb",
	"debugpy",
	"delve",
	"docker-compose-language-service",
	"dockerfile-language-server",
	"gofumpt",
	"goimports",
	"golangci-lint",
	"gopls",
	"hadolint",
	"js-debug-adapter",
	"json-lsp",
	"ltex-ls",
	"lua-language-server",
	"markdown-toc",
	"markdownlint-cli2",
	"marksman",
	"mypy",
	"neocmakelsp",
	"nil",
	"prettier",
	"pyproject-fmt",
	"pyright",
	"ruff",
	"shfmt",
	"stylua",
	"tailwindcss-language-server",
	"taplo",
	"texlab",
	"tree-sitter-cli",
	"vtsls",
	"yaml-language-server",
}

return {
	{
		"mason-org/mason.nvim",
		-- event = "VeryLazy",
		lazy = false,
		opts = function(_, opts)
			opts.ensure_installed = mason_packages
			_G.MasonInstallEnsureInstalled = function()
				for _, pkg in ipairs(mason_packages) do
					print("Installing package: " .. pkg)
					vim.cmd("MasonInstall " .. table.concat(mason_packages, " "))
				end
			end
			vim.api.nvim_create_user_command(
				"MasonInstallEnsureInstalled",
				_G.MasonInstallEnsureInstalled,
				{ nargs = "*" }
			)
			return opts
		end,
	},
}
