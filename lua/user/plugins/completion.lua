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

--custom["luozhiya/fittencode.nvim"] = {
--	lazy = true,
--	event = { "CmdlineEnter" },
--	config = require("user.configs.tool.fittencode"),
--}

custom["dpayne/CodeGPT.nvim"] = {
	lazy = true,
	event = { "CmdlineEnter" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	config = require("user.configs.tool.groq"),
}

return custom
