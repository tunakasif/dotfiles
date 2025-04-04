-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	---@cast keys LazyKeysHandler
	-- do not create the keymap if a lazy keys handler exists
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		if opts.remap and not vim.g.vscode then
			opts.remap = nil
		end
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

-- Copy/Paste to/from clipboard
map("v", "p", '"_dP', {}) -- keep yanked

map("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map("n", "<leader>yy", '"+yy', { desc = "Copy current line to system clipboard" })
map("n", "<leader>Y", '"+y$', { desc = "Copy rest of the line to system clipboard" })
map("n", "<leader>p", '"+p', { desc = "Paste  after from system clipboard" })
map("n", "<leader>P", '"+P', { desc = "Paste before from system clipboard" })
map("v", "<leader>p", '"+p', { desc = "Paste  after from system clipboard" })
map("v", "<leader>P", '"+P', { desc = "Paste before from system clipboard" })
