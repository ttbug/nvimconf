local editor = {}
local conf = require("modules.editor.config")

editor["junegunn/vim-easy-align"] = { opt = true, cmd = "EasyAlign" }
editor["RRethy/vim-illuminate"] = {
	opt = true,
	event = "BufReadPost",
	config = conf.illuminate,
}
editor["terrortylor/nvim-comment"] = {
	opt = false,
	config = conf.nvim_comment,
}
editor["nvim-treesitter/nvim-treesitter"] = {
	opt = true,
	run = ":TSUpdate",
	event = "BufReadPost",
	config = conf.nvim_treesitter,
}
editor["nvim-treesitter/nvim-treesitter-textobjects"] = {
	opt = true,
	after = "nvim-treesitter",
    commit = "761e283a8e3ab80ee5ec8daf4f19d92d23ee37e4",
}
editor["p00f/nvim-ts-rainbow"] = {
	opt = true,
	after = "nvim-treesitter",
	--event = "BufReadPost",
}
editor["JoosepAlviste/nvim-ts-context-commentstring"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor["mfussenegger/nvim-ts-hint-textobject"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor["windwp/nvim-ts-autotag"] = {
	opt = true,
	after = "nvim-treesitter",
	config = conf.autotag,
}
editor["andymass/vim-matchup"] = {
	opt = true,
	after = "nvim-treesitter",
	config = conf.matchup,
}
--editor["rhysd/accelerated-jk"] = { opt = true, event = "BufWinEnter" }
editor["rainbowhxch/accelerated-jk.nvim"] = { opt = true, event = "BufWinEnter", config = conf.accelerated_jk }
editor["hrsh7th/vim-eft"] = { opt = true, event = "BufReadPost" }
editor["romainl/vim-cool"] = {
	opt = true,
	event = { "CursorMoved", "InsertEnter" },
}

editor["phaazon/hop.nvim"] = {
	opt = true,
	branch = "v2",
	event = "BufReadPost",
	config = conf.hop,
}
editor["easymotion/vim-easymotion"] = { opt = true, config = conf.easymotion }
editor["karb94/neoscroll.nvim"] = {
	opt = true,
	event = "WinScrolled",
	config = conf.neoscroll,
}
editor["akinsho/toggleterm.nvim"] = {
	opt = true,
	event = "UIEnter",
	config = conf.toggleterm,
}
--editor["vimlab/split-term.vim"] = { opt = true, cmd = { "Term", "VTerm" } }
editor["norcalli/nvim-colorizer.lua"] = {
	opt = true,
	event = "BufRead",
	config = conf.nvim_colorizer,
}
--editor["numtostr/FTerm.nvim"] = { opt = true, event = "BufRead" }
editor["rmagatti/auto-session"] = {
	opt = true,
	cmd = { "SaveSession", "RestoreSession", "DeleteSession" },
	config = conf.auto_session,
}
--editor['jdhao/better-escape.vim'] = {
--    opt = true,
--    event = 'InsertEnter'
--}

editor["max397574/better-escape.nvim"] = {
	opt = true,
	event = "BufReadPost",
	config = conf.better_escape,
}

editor["rcarriga/nvim-dap-ui"] = {
	opt = true,
	config = conf.dapui,
}
editor["mfussenegger/nvim-dap"] = {
	opt = true,
	cmd = "DapToggleBreakpoint",
	config = conf.dap,
}
--editor["tpope/vim-fugitive"] = { opt = true, cmd = { "Git", "G" } }
editor["famiu/bufdelete.nvim"] = {
	opt = true,
	cmd = { "Bdelete", "Bwipeout", "Bdelete!", "Bwipeout!" },
}

editor["edluffy/specs.nvim"] = {
	opt = true,
	event = "CursorMoved",
	config = conf.specs,
}
editor["abecodes/tabout.nvim"] = {
	opt = true,
	event = "InsertEnter",
	wants = "nvim-treesitter",
	after = "nvim-cmp",
	config = conf.tabout,
}

editor["theHamsta/nvim-dap-virtual-text"] = {
	opt = true,
	cmd = { "DapVirtualTextEnable", "DapVirtualTextDisable" },
	config = conf.dap_virtual_text,
}
editor["sindrets/diffview.nvim"] = {
	opt = true,
	cmd = { "DiffviewOpen" },
}

editor["luukvbaal/stabilize.nvim"] = {
	opt = true,
	event = "BufReadPost",
}

--editor["numtostr/FTerm.nvim"] = {
--    opt = true,
--    event = "BufReadPost",
--    config = conf.fterm,
--}

return editor
