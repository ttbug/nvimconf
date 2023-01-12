local lang = {}
local conf = require("modules.lang.config")

lang["ray-x/go.nvim"] = {
    opt = true,
    ft = "go",
    --after = "mason-lspconfig.nvim",
    event = "BufReadPost",
    config = conf.go,
    --requires = {{"ray-x/guihua.lua", opt=true}}
}

lang["ray-x/guihua.lua"] = {
    opt = true,
    run = 'cd lua/fzy && make'
}
--lang["rust-lang/rust.vim"] = { opt = true, ft = "rust" }
lang["simrat39/rust-tools.nvim"] = {
	opt = true,
	ft = "rust",
	config = conf.rust_tools,
    requires = "nvim-lua/plenary.nvim",
}

lang["chrisbra/csv.vim"] = { opt = true, ft = "csv" }
return lang
