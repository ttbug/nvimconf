local lang = {}
local conf = require("modules.lang.config")

lang["ray-x/go.nvim"] = {
    opt = true,
    ft = "go",
    after = "mason-lspconfig.nvim",
    config = conf.go,
    --requires = {{"ray-x/guihua.lua", opt=true}}
}

lang["ray-x/guihua.lua"] = {
    opt = true,
}
--lang["rust-lang/rust.vim"] = { opt = true, ft = "rust" }
lang["simrat39/rust-tools.nvim"] = {
	opt = true,
	ft = "rust",
	config = conf.rust_tools,
	requires = { { "nvim-lua/plenary.nvim", opt = false } },
}

lang["chrisbra/csv.vim"] = { opt = true, ft = "csv" }
return lang
