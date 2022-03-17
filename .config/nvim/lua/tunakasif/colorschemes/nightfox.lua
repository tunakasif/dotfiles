local status_ok, nightfox = pcall(require, "nightfox")
if not status_ok then
	return
end

-- Default options
-- Default options
require("nightfox").setup({})

-- setup must be called before loading
vim.cmd("colorscheme nordfox")
