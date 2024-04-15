local custom = {}

--custom["Exafunction/codeium.nvim"] = {
--	lazy = true,
--	event = { "CmdlineEnter" },
--	dependencies = {
--		"nvim-lua/plenary.nvim",
--		"hrsh7th/nvim-cmp",
--	},
--	config = require("user.configs.tool.codeium"),
--}

custom["luozhiya/fittencode.nvim"] = {
	lazy = true,
	event = { "CmdlineEnter" },
	config = require("user.configs.tool.fittencode"),
}

return custom
