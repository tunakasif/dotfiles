return {
	"kaarmu/typst.vim",
	ft = "typst",
	lazy = true,
	event = "BufRead",
	config = function()
		vim.filetype.add({ extension = { typ = "typst" } })
	end,
}
