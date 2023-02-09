local lang = {}

lang["ray-x/go.nvim"] = {
	lazy = true,
	build = ":GoInstallBinaries",
	ft = "go",
	-- event = "BufReadPost",
	config = require("lang.vim-go"),
	dependencies = { "ray-x/guihua.lua" },
}

lang["simrat39/rust-tools.nvim"] = {
	lazy = true,
	ft = "rust",
	config = require("lang.rust-tools"),
	dependencies = { "nvim-lua/plenary.nvim" },
}
lang["chrisbra/csv.vim"] = {
	lazy = true,
	ft = "csv",
}
return lang
