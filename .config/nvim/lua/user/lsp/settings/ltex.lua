local paths = {
	vim.fn.stdpath("config") .. "/spell/ltex.dictionary.en-US.txt",
	vim.fn.expand("%:p:h") .. "/spell/ltex.dictionary.en-US.txt",
	vim.fn.expand("%:p:h") .. "/.vscode/ltex.dictionary.en-US.txt",
}

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

return {
	settings = {
		ltex = {
			dictionary = {
				["en-US"] = words,
			},
		},
	},
}
