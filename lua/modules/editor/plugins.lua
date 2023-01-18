local editor = {}
local conf = require("modules.editor.config")

editor["junegunn/vim-easy-align"] = { lazy = true, cmd = "EasyAlign" }
editor["RRethy/vim-illuminate"] = {
	lazy = true,
	event = "BufReadPost",
	config = conf.illuminate,
}
editor["terrortylor/nvim-comment"] = {
	lazy = false,
	event = "BufReadPost",
	config = conf.nvim_comment,
}
editor["nvim-treesitter/nvim-treesitter"] = {
	lazy = true,
	build = ":TSUpdate",
	event = "BufReadPost",
	config = conf.nvim_treesitter,
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
		{ "p00f/nvim-ts-rainbow" },
		{ "JoosepAlviste/nvim-ts-context-commentstring" },
		{ "mfussenegger/nvim-ts-hint-textobject" },
		{ "andymass/vim-matchup" },
		{ "windwp/nvim-ts-autotag", config = conf.autotag },
		{ "NvChad/nvim-colorizer.lua", config = conf.nvim_colorizer },
	},
}

editor["rainbowhxch/accelerated-jk.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	config = conf.accelerated_jk,
}
editor["rhysd/clever-f.vim"] = {
	lazy = true,
	event = "BufReadPost",
	config = conf.clever_f,
}
editor["romainl/vim-cool"] = {
	lazy = true,
	event = { "CursorMoved", "InsertEnter" },
}

editor["phaazon/hop.nvim"] = {
	lazy = true,
	branch = "v2",
	event = "BufReadPost",
	config = conf.hop,
}
editor["easymotion/vim-easymotion"] = { lazy = true, config = conf.easymotion }
editor["karb94/neoscroll.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = conf.neoscroll,
}
editor["akinsho/toggleterm.nvim"] = {
	lazy = true,
	event = "UIEnter",
	config = conf.toggleterm,
}
editor["rmagatti/auto-session"] = {
	lazy = true,
	cmd = { "SaveSession", "RestoreSession", "DeleteSession" },
	config = conf.auto_session,
}
editor["max397574/better-escape.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = conf.better_escape,
}
editor["mfussenegger/nvim-dap"] = {
	lazy = true,
	cmd = {
		"DapSetLogLevel",
		"DapShowLog",
		"DapContinue",
		"DapToggleBreakpoint",
		"DapToggleRepl",
		"DapStepOver",
		"DapStepInto",
		"DapStepOut",
		"DapTerminate",
	},
	config = conf.dap,
	dependencies = {
		{ "rcarriga/nvim-dap-ui", config = conf.dapui },
	},
}
editor["rcarriga/nvim-dap-ui"] = {
	lazy = true,
	after = "nvim-dap", -- Need to call setup after dap has been initialized.
	config = conf.dapui,
}
editor["tpope/vim-fugitive"] = {
	lazy = true,
	cmd = { "Git", "G" },
}

editor["ojroques/nvim-bufdel"] = {
	lazy = true,
	event = "BufReadPost",
}

editor["edluffy/specs.nvim"] = {
	lazy = true,
	event = "CursorMoved",
	config = conf.specs,
}

editor["theHamsta/nvim-dap-virtual-text"] = {
	lazy = true,
	cmd = { "DapVirtualTextEnable", "DapVirtualTextDisable" },
	config = conf.dap_virtual_text,
}
editor["sindrets/diffview.nvim"] = {
	lazy = true,
	cmd = { "DiffviewOpen", "DiffviewClose" },
}
editor["luukvbaal/stabilize.nvim"] = {
	lazy = true,
	event = "BufReadPost",
}
editor["ibhagwan/smartyank.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = conf.smartyank,
}

return editor

