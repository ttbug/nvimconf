local custom = {}

custom["Exafunction/codeium.nvim"] = {
	lazy = true,
	event = { "CmdlineEnter" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = require("user.configs.tool.codeium"),
}

return custom
