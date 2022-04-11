local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = "all",
	sync_install = false,
	ignore_install = { "" },
	autopairs = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	highlight = {
		enable = true,
		disable = { "" },
		additional_vim_regex_highlighting = true,
	},
	indent = {
		enable = true,
		disable = { "yaml" },
	},
	rainbow = {
		enable = false,
		disable = { "" },
		extended_mode = true,
		max_file_lines = nil,
		-- colors {},  -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
})
