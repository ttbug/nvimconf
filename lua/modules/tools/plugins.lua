local tools = {}
local conf = require("modules.tools.config")

tools["nvim-lua/plenary.nvim"] = { opt = false }

--tools["RishabhRD/popfix"] = {opt = false}
tools["aspeddro/gitui.nvim"] = {
	opt = false,
	config = function()
		require("gitui").setup({})
	end,
}

tools["ttbug/tig.nvim"] = {
	opt = false,
	config = function()
		require("tig").setup({})
	end,
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
	requires = { {
		"ahmedkhalf/project.nvim",
		opt = true,
		config = conf.project,
	} },
}
tools["nvim-telescope/telescope-frecency.nvim"] = {
	opt = true,
	after = "telescope-project.nvim",
	--requires = { { "tami5/sqlite.lua", opt = true } },
	requires = { { "kkharji/sqlite.lua", opt = true } },
}

tools["jvgrootveld/telescope-zoxide"] = {
	opt = true,
	after = "telescope-frecency.nvim",
}
tools["michaelb/sniprun"] = {
	opt = true,
	run = "bash ./install.sh",
	cmd = { "SnipRun", "'<,'>SnipRun" },
}
-- Please don't remove which-key.nvim otherwise you need to set timeoutlen=300 at `lua/core/options.lua`
tools["folke/which-key.nvim"] = {
	opt = false,
	--keys = ",",
	--keys = "<leader>",
	config = conf.which_key,
}
tools["nvim-telescope/telescope-ui-select.nvim"] = {
	opt = true,
	after = "telescope-zoxide",
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

tools["mg979/vim-visual-multi"] = { opt = false }
tools["folke/todo-comments.nvim"] = {
	opt = false,
	requires = { { "nvim-lua/plenary.nvim", opt = false } },
	config = conf.todo,
}

tools["antoinemadec/FixCursorHold.nvim"] = {
	opt = false,
	config = conf.perf,
}

tools["mrjones2014/legendary.nvim"] = {
	opt = true,
	cmd = "Legendary",
	config = conf.legendary,
	requires = {
		{ "stevearc/dressing.nvim", opt = false, config = conf.dressing },
		"kkharji/sqlite.lua",
		"folke/which-key.nvim",
	},
}

tools["nvim-telescope/telescope-live-grep-args.nvim"] = {
	opt = true,
	after = "telescope-zoxide",
}

--tools["folke/noice.nvim"] = {
--	opt = false,
--	event = "VimEnter",
--	config = function()
--		require("noice").setup()
--	end,
--	requires = {
--		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
--		"MunifTanjim/nui.nvim",
--		-- OPTIONAL:
--		--   `nvim-notify` is only needed, if you want to use the notification view.
--		--   If not available, we use `mini` as the fallback
--		--"rcarriga/nvim-notify",
--	},
--}

return tools
