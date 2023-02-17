local lang = {}

lang["ray-x/go.nvim"] = {
	lazy = true,
	build = ":GoInstallBinaries",
	ft = "go",
	event = { "CmdwinEnter", "CmdlineEnter" },
	-- event = "BufReadPost",
	config = require("lang.vim-go"),
}

lang["ray-x/guihua.lua"] = {
	lazy = true,
	build = "cd lua/fzy && make",
}

lang["Saecki/crates.nvim"] = {
	lazy = true,
	event = "BufReadPost Cargo.toml",
	config = require("lang.crates"),
	dependencies = { "nvim-lua/plenary.nvim" },
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
