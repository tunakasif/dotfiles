local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--hlsearch toggle
keymap("n", "<leader>/", ":noh<CR>", opts)

--remap split navigations
keymap("n", "<C-J>", "<C-W><C-J>", opts)
keymap("n", "<C-K>", "<C-W><C-K>", opts)
keymap("n", "<C-L>", "<C-W><C-L>", opts)
keymap("n", "<C-H>", "<C-W><C-H>", opts)

--shift between buffers
keymap("n", "<S-L>", ":bnext<CR>", opts)
keymap("n", "<S-H>", ":bprevious<CR>", opts)

--shift text up & down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

--adjust split sizes with arrow keys
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)

--visual tabbing mode
keymap("v", "<", "< gv", opts)
keymap("v", ">", "> gv", opts)

-- keep yanked
keymap("v", "p", '"_dP', opts)

-- Copy to clipboard
keymap("n", "<leader>y", '"+y', opts)
keymap("v", "<leader>y", '"+y', opts)
keymap("n", "<leader>Y", '"+yg_', opts)
keymap("n", "<leader>yy", '"+yy', opts)

-- Paste from clipboard
keymap("n", "<leader>p", '"+p', opts)
keymap("n", "<leader>P", '"+P', opts)
keymap("v", "<leader>p", '"+p', opts)
keymap("v", "<leader>P", '"+P', opts)

-- toggle wrap
function TOGGLE_WRAP()
	vim.opt.wrap = not vim.opt.wrap:get()
end
keymap("n", "<leader>ww", ":lua TOGGLE_WRAP()<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope find_files hidden=true<CR>", opts)
keymap("n", "<leader>ft", "<cmd>Telescope help_tags<CR>", opts)
keymap("n", "<leader>fp", "<cmd>Telescope projects<CR>", opts)

-- TreeSitter
-- There is problem with the :TSToggle when the module starts as `false`.
-- In addition :TSEnableAll rainbow does not on the first try, two calls
-- are necessary for enabling.
function ENABLE_RAINBOW()
	vim.cmd([[:TSEnable rainbow]])
	vim.cmd([[:TSEnable rainbow]])
end
function DISABLE_RAINBOW()
	vim.cmd([[:TSDisable rainbow]])
end
keymap("n", "<leader>r(", ":lua ENABLE_RAINBOW()<CR>", opts)
keymap("n", "<leader>r)", ":lua DISABLE_RAINBOW()<CR>", opts)

-- Transparent toggle
keymap("n", "<leader>tr", ":TransparentToggle<CR>", opts)

-- Nvim Tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR> :NvimTreeRefresh<CR>", opts)

-- Vim BBye
keymap("n", "<leader>q", ":Bdelete<CR>", opts)

-- toggle term
keymap("n", "<leader>tt", ":ToggleTerm direction=float<CR>", opts)
keymap("n", "<leader><Bslash>", ":ToggleTerm direction=horizontal<CR>", opts)

-- Glow
vim.cmd("autocmd Filetype markdown nnoremap <leader>vv :Glow<CR>")
vim.cmd("autocmd Filetype rmarkdown nnoremap <leader>vv :RMarkdown pdf<CR>")

-- Trouble
keymap("n", "<leader>xx", ":TroubleToggle<CR>", opts)
keymap("n", "<leader>xw", ":Trouble workspace_diagnostics<CR>", opts)
keymap("n", "<leader>xd", ":Trouble document_diagnostics<CR>", opts)
keymap("n", "<leader>xl", ":Trouble loclist<CR>", opts)
keymap("n", "<leader>xq", ":Trouble quickfix<CR>", opts)
keymap("n", "gR", ":Trouble lsp_references<CR>", opts)

-- copilot
function TOGGLE_COPILOT()
	if vim.b.copilot_enabled == nil then
		vim.b.copilot_enabled = false
	end
	if vim.b.copilot_enabled then
		vim.b.copilot_enabled = false
		vim.cmd([[:Copilot disable <CR>]])
	else
		vim.b.copilot_enabled = true
		vim.cmd([[:Copilot enable <CR>]])
	end
	vim.cmd([[:Copilot status <CR>]])
end
keymap("n", "<leader>cp", ":lua TOGGLE_COPILOT()<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
