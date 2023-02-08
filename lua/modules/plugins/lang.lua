local lang = {}

lang["ray-x/go.nvim"] = {
        lazy = true,
        build = ":GoInstallBinaries",
        ft = "go",
        -- event = "BufReadPost",
	config = require("lang.vim-go"),
}

lang["simrat39/rust-tools.nvim"] = {
	lazy = true,
	ft = "rust",
	config = require("lang.rust-tools"),
	dependencies = { "nvim-lua/plenary.nvim" },
}
lang["iamcco/markdown-preview.nvim"] = {
	lazy = true,
	ft = "markdown",
	build = ":call mkdp#util#install()",
}
lang["chrisbra/csv.vim"] = {
	lazy = true,
	ft = "csv",
}
return lang
