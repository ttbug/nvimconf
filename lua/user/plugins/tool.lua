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

--custom["okuuva/auto-save.nvim"] = {
--	lazy = true,
--	cmd = "ASToggle", -- optional for lazy loading on command
--	event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
--	config = true,
--}

return custom
