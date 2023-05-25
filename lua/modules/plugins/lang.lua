local lang = {}

lang["ray-x/go.nvim"] = {
	lazy = true,
	ft = { "go", "gomod" },
	event = { "CmdlineEnter" },
	-- event = "BufReadPost",
	config = require("lang.go-nvim"),
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
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
lang["ellisonleao/glow.nvim"] = {
	lazy = true,
	cmd = "Glow",
	config = require("lang.glow"),
}
return lang
