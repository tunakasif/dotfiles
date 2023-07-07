return {
	"kaarmu/typst.vim",
	ft = "typst",
	lazy = false,
	config = function()
		vim.filetype.add({ extension = { typ = "typst" } })
	end,
}
