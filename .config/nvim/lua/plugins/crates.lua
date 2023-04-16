return {
	"saecki/crates.nvim",
	ft = { "toml" },
	config = function(_, opts)
		local crates = require("crates")
		crates.setup(opts)
		crates.show()
	end,
}
