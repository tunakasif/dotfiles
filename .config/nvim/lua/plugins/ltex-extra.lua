local function get_ignored_words(paths)
	local words = {}
	for _, path in ipairs(paths) do
		local f = io.open(path)
		if f then
			for word in f:lines() do
				table.insert(words, word)
			end
			f:close()
		end
	end
	return words
end

local paths = {
	vim.fn.stdpath("config") .. "/spell/ltex.dictionary.en-US.txt",
	vim.fn.expand("%:p:h") .. "/spell/ltex.dictionary.en-US.txt",
	vim.fn.expand("%:p:h") .. "/.vscode/ltex.dictionary.en-US.txt",
	vim.fn.expand("%:p:h") .. "/ltex.dictionary.en-US.txt",
}
local words = get_ignored_words(paths)

return {
	"barreiroleo/ltex_extra.nvim",
	ft = { "markdown", "tex", "gitcommit" },
	dependencies = { "neovim/nvim-lspconfig" },
	config = function()
		require("ltex_extra").setup({
			path = ".vscode",
			server_opts = {
				settings = {
					ltex = {
						checkFrequency = "save",
						dictionary = {
							["en-US"] = words,
						},
					},
				},
			},
		})
	end,
}
