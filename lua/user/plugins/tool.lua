local custom = {}

--custom["folke/flash.nvim"] = {
--	lazy = true,
--	event = { "VeryLazy" },
--	config = true,
--}

custom["mg979/vim-visual-multi"] = {
	lazy = false,
}

custom["leoluz/nvim-dap-go"] = {
	lazy = true,
	config = function()
		require("dap-go").setup()
	end,
}

custom["sourcegraph/sg.nvim"] = {
	lazy = true,
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]]
	},
	config = function()
		require("sg").setup({
			enable_cody = true,
		})
	end,
}

--custom["okuuva/auto-save.nvim"] = {
--	lazy = true,
--	cmd = "ASToggle", -- optional for lazy loading on command
--	event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
--	config = true,
--}

return custom
