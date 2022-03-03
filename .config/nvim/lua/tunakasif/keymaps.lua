local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

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

-- toggle wrap
function TOGGLE_WRAP()
	vim.opt.wrap = not vim.opt.wrap:get()
end
keymap("n", "<leader>ww", ":lua TOGGLE_WRAP()<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)

-- TreeSitter
-- There is problem with the :TSToggle when the module starts as `false`.
-- In addition :TSEnableAll rainbow does not on the first try, two calls
-- are necessary for enabling.
function ENABLE_RAINBOW()
	vim.cmd([[:TSEnableAll rainbow]])
	vim.cmd([[:TSEnableAll rainbow]])
end
function DISABLE_RAINBOW()
	vim.cmd([[:TSDisableAll rainbow]])
end
keymap("n", "<leader>r(", ":lua ENABLE_RAINBOW()<CR>", opts)
keymap("n", "<leader>r)", ":lua DISABLE_RAINBOW()<CR>", opts)

-- Transparent toggle
keymap("n", "<leader>tt", ":TransparentToggle<CR>", opts)

-- Nvim Tree
keymap("n", "<C-E>", ":NvimTreeToggle<CR>", opts)

-- Vim BBye
keymap("n", "<leader>q", ":Bdelete<CR>", opts)

-- toggle term
keymap("n", "<leader><Bslash>", ":ToggleTerm<CR>", opts)

-- Glow
vim.cmd("autocmd Filetype markdown nnoremap <leader>p :Glow<CR>")

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
