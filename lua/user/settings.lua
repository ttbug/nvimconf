-- Please check `lua/core/settings.lua` to view the full list of configurable settings
local settings = {}

-- Examples
settings["use_ssh"] = false

-- Set the colorscheme to use here.
-- Available values are: `catppuccin`, `catppuccin-latte`, `catppucin-mocha`, `catppuccin-frappe`, `catppuccin-macchiato`, `edge`, `nord`.
---@type string
--settings["colorscheme"] = "catppuccin-mocha"
settings["colorscheme"] = "tokyonight-storm"
-- Set it to true if your terminal has transparent background.
---@type boolean
settings["transparent_background"] = true
-- Set the plugins to disable here.
-- Example: "Some-User/A-Repo"
---@type string[]
settings["disabled_plugins"] = {
	"iamcco/markdown-preview.nvim",
	"fatih/vim-go",
	"rhysd/clever-f.vim",
	"tpope/vim-fugitive",
	"dstein64/nvim-scrollview",
}

-- Set the general-purpose servers that will be installed during bootstrap here
-- check the below link for all supported sources
-- in `code_actions`, `completion`, `diagnostics`, `formatting`, `hover` folders:
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins
---@type string[]
settings["null_ls_deps"] = {
	-- formatting
	"clang_format",
	"editorconfig_checker",
	"prettier",
	"shfmt",
	"stylua",
	"gofumpt",
	"goimports",

	"vint",
}
-- Set it to false if you don't use copilot
---@type boolean
settings["use_copilot"] = false

return settings
