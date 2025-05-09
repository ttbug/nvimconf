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


return custom
