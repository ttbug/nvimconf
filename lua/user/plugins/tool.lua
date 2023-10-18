local custom = {}

custom["folke/flash.nvim"] = {
	lazy = true,
	event = { "VeryLazy" },
	config = true,
}

custom["Wansmer/symbol-usage.nvim"] = {
	lazy = true,
	event = "BufReadPre",
	config = require("user.configs.tool.suse"),
}

return custom
