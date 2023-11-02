local custom = {}

custom["ray-x/go.nvim"] = {
	lazy = true,
	ft = { "go", "gomod" },
	event = { "CmdlineEnter" },
	-- event = "BufReadPost",
	config = require("user.configs.lang.go"),
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}

--custom["ziglang/zig.vim"] = {
--	lazy = true,
--	event = { "CmdlineEnter" },
--}

return custom
