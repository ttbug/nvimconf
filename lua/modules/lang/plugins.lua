local lang = {}
local conf = require("modules.lang.config")

lang["ray-x/go.nvim"] = {
	lazy = true,
	build = ":GoInstallBinaries",
	ft = "go",
	-- event = "BufReadPost",
	config = conf.go,
}

lang["ray-x/guihua.lua"] = {
	lazy = true,
	run = "cd lua/fzy && make",
}
--lang["rust-lang/rust.vim"] = { opt = true, ft = "rust" }
lang["simrat39/rust-tools.nvim"] = {
	lazy = true,
	ft = "rust",
	config = conf.rust_tools,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
}

lang["chrisbra/csv.vim"] = { lazy = true, ft = "csv" }
return lang

