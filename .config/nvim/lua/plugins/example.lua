-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
if false then return {} end

-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin",
		},
	},

	-- change trouble config
	{
		"folke/trouble.nvim",
		opts = { use_diagnostic_signs = true },
	},

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
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

	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				-- pyright will be automatically installed with mason and loaded with lspconfig
				pyright = {},
			},
		},
	},

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			-- add tsx and treesitter
			vim.list_extend(opts.ensure_installed, {
				"tsx",
				"typescript",
			})
		end,
	},

	-- mason
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"shellcheck",
				"shfmt",
				"flake8",
			},
		},
	},

	-- Use <tab> for completion and snippets (supertab)
	-- first: disable default <tab> and <s-tab> behavior in LuaSnip
	-- 	{
	-- 		"L3MON4D3/LuaSnip",
	-- 		keys = function()
	-- 			return {}
	-- 		end,
	-- 	},
	-- 	-- then: setup supertab in cmp
	-- 	{
	-- 		"hrsh7th/nvim-cmp",
	-- 		dependencies = {
	-- 			"hrsh7th/cmp-emoji",
	-- 		},
	-- 		---@param opts cmp.ConfigSchema
	-- 		opts = function(_, opts)
	-- 			local has_words_before = function()
	-- 				unpack = unpack or table.unpack
	-- 				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	-- 				return col ~= 0
	-- 					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	-- 			end
	--
	-- 			local luasnip = require("luasnip")
	-- 			local cmp = require("cmp")
	--
	-- 			opts.mapping = vim.tbl_extend("force", opts.mapping, {
	-- 				["<Tab>"] = cmp.mapping(function(fallback)
	-- 					if cmp.visible() then
	-- 						cmp.select_next_item()
	-- 					-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
	-- 					-- they way you will only jump inside the snippet region
	-- 					elseif luasnip.expand_or_jumpable() then
	-- 						luasnip.expand_or_jump()
	-- 					elseif has_words_before() then
	-- 						cmp.complete()
	-- 					else
	-- 						fallback()
	-- 					end
	-- 				end, { "i", "s" }),
	-- 				["<S-Tab>"] = cmp.mapping(function(fallback)
	-- 					if cmp.visible() then
	-- 						cmp.select_prev_item()
	-- 					elseif luasnip.jumpable(-1) then
	-- 						luasnip.jump(-1)
	-- 					else
	-- 						fallback()
	-- 					end
	-- 				end, { "i", "s" }),
	-- 			})
	-- 		end,
	-- 	},
}
