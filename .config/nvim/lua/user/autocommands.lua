-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
	end,
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({ "User" }, {
	pattern = { "AlphaReady" },
	callback = function()
		vim.cmd([[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]])
	end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

-- Currently Functions
function COMPILE_RMD_ON_SAVE()
	print("Compiling Rmd on save")
	vim.cmd([[
      augroup packer_user_config
        autocmd!
        autocmd BufWritePost *.Rmd RMarkdown pdf
      augroup end
    ]])
end

function TOGGLE_FORMAT_ON_SAVE(verbose)
	verbose = verbose or false
	if FORMAT_ON_SAVE then
		vim.cmd([[
            augroup LspFormatOnSave
                autocmd!
            augroup END
        ]])
	else
		vim.cmd([[
            augroup LspFormatOnSave
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
        ]])
	end
	FORMAT_ON_SAVE = not FORMAT_ON_SAVE
	if verbose then
		print("Format on save: " .. (FORMAT_ON_SAVE and "on" or "off"))
	end
end
