local ui = {}
local conf = require("modules.ui.config")

ui["kyazdani42/nvim-web-devicons"] = { opt = false }
ui["sainnhe/edge"] = { opt = false, config = conf.edge }
--ui["folke/tokyonight.nvim"] = { opt = false, config = conf.tokyonight }
ui["catppuccin/nvim"] = {
	opt = false,
	as = "catppuccin",
	config = conf.catppuccin,
}
ui["rcarriga/nvim-notify"] = {
	opt = false,
	config = conf.notify,
}
ui["hoob3rt/lualine.nvim"] = {
	opt = true,
	after = "nvim-lspconfig",
	config = conf.lualine,
}

ui["goolord/alpha-nvim"] = {
	opt = true,
	event = "BufWinEnter",
	config = conf.alpha,
}
ui["kyazdani42/nvim-tree.lua"] = {
	opt = true,
	cmd = {
		"NvimTreeToggle",
		"NvimTreeOpen",
		"NvimTreeFindFile",
		"NvimTreeFindFileToggle",
		"NvimTreeRefresh",
	},
	config = conf.nvim_tree,
}
ui["lewis6991/gitsigns.nvim"] = {
	opt = true,
	event = { "BufReadPost", "BufNewFile" },
	config = conf.gitsigns,
}
ui["lukas-reineke/indent-blankline.nvim"] = {
	opt = true,
	event = "BufReadPost",
	config = conf.indent_blankline,
}
ui["akinsho/bufferline.nvim"] = {
	opt = false,
	tag = "*",
	event = "BufReadPost",
	config = conf.nvim_bufferline,
}

ui["j-hui/fidget.nvim"] = {
	opt = true,
	event = "BufReadPost",
	config = conf.fidget,
}

ui["stevearc/dressing.nvim"] = {
	opt = true,
	event = "BufReadPost",
}

ui["zbirenbaum/neodim"] = {
	opt = true,
	event = "LspAttach",
	requires = "nvim-treesitter",
	config = conf.neodim,
}

return ui
