local custom = {}

custom["folke/todo-comments.nvim"] = {
	lazy = true,
	event = { "CmdlineEnter" },
	config = require("user.configs.editor.todo-comments"),
	dependencies = { "nvim-lua/plenary.nvim" },
}

return custom
