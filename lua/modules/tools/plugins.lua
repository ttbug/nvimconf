local tools = {}
local conf = require('modules.tools.config')

tools["nvim-lua/plenary.nvim"] = { opt = false }

--tools["RishabhRD/popfix"] = {opt = false}
tools["aspeddro/gitui.nvim"] = {
    opt = false,
    config = function() require("gitui").setup {} end
}

tools["ttbug/tig.nvim"] = {
    opt = false,
    config = function() require("tig").setup{} end
}

tools["nvim-telescope/telescope.nvim"] = {
	opt = true,
	module = "telescope",
	cmd = "Telescope",
	config = conf.telescope,
	requires = {
		{ "nvim-lua/plenary.nvim", opt = false },
		{ "nvim-lua/popup.nvim", opt = true },
	},
}
tools["nvim-telescope/telescope-fzf-native.nvim"] = {
	opt = true,
	run = "make",
	after = "telescope.nvim",
}
tools["nvim-telescope/telescope-project.nvim"] = {
	opt = true,
	after = "telescope-fzf-native.nvim",
}
tools["nvim-telescope/telescope-frecency.nvim"] = {
	opt = true,
	after = "telescope-project.nvim",
	--requires = { { "tami5/sqlite.lua", opt = true } },
    requires = { { "kkharji/sqlite.lua", opt = true } },
}

tools["jvgrootveld/telescope-zoxide"] = { opt = true, after = "telescope-frecency.nvim" }
tools["michaelb/sniprun"] = {
	opt = true,
	run = "bash ./install.sh",
	cmd = { "SnipRun", "'<,'>SnipRun" },
}
tools["folke/which-key.nvim"] = {
	opt = true,
	--keys = ",",
    keys = "<leader>",
	config = conf.which_key,
}
tools["folke/trouble.nvim"] = {
	opt = true,
	cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
	config = conf.trouble,
}
tools["dstein64/vim-startuptime"] = { opt = true, cmd = "StartupTime" }
tools["gelguy/wilder.nvim"] = {
	event = "CmdlineEnter",
	config = conf.wilder,
	requires = { { "romgrk/fzy-lua-native", after = "wilder.nvim" } },
}

-- tools['nathom/filetype.nvim'] = {opt = false}
tools['mg979/vim-visual-multi'] = {opt = false}
tools["nathom/filetype.nvim"] = {
	opt = false,
	config = conf.filetype,
}
tools['folke/todo-comments.nvim'] = {
    opt = false,
    requires = {{'nvim-lua/plenary.nvim', opt = false}},
    config = conf.todo,
}

tools['antoinemadec/FixCursorHold.nvim'] = {
    opt = false,
    config = conf.perf,
}

return tools
