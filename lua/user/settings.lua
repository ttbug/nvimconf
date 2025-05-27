-- Please check `lua/core/settings.lua` to view the full list of configurable settings
local settings = {}

-- Examples
settings["use_ssh"] = false

-- Set it to false if you don't use AI chat functionality.
---@type boolean
settings["use_chat"] = true

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
	"Bekaboo/dropbar.nvim",
	"MeanderingProgrammer/render-markdown.nvim",
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
	-- "prettier",
	"shfmt",
	"stylua",
	"gofumpt",
	"goimports",

	"vint",
}

-- Set the language servers that will be installed during bootstrap here.
-- check the below link for all the supported LSPs:
-- https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/server_configurations
---@type string[]
settings["lsp_deps"] = {
	--"bashls",
	-- "clangd",
	-- "html",
	-- "jsonls",
	"lua_ls",
	"pylsp",
	"gopls",
}
-- Set it to false if you don't use copilot
---@type boolean
settings["use_copilot"] = true

-- Set it to false if you want to turn off LSP Inlay Hints
---@type boolean
settings["lsp_inlayhints"] = false

-- Set it to one of the values below if you want to change the visible severity level of lsp diagnostics.
-- Priority: `Error` > `Warning` > `Information` > `Hint`.
--  > e.g. if you set this option to `Warning`, only lsp warnings and errors will be shown.
-- NOTE: This entry only works when `diagnostics_virtual_text` is true.
---@type "ERROR"|"WARN"|"INFO"|"HINT"
settings["diagnostics_level"] = "WARN"

-- Set the search backend to use here.
-- telescope is enough for most cases.
-- fzf is more powerful for searching in huge repo but needs fzf binary installed.
---@type "telescope"|"fzf"
settings["search_backend"] = "telescope"

return settings
