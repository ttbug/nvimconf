local settings = {}

-- Set to false if you want to use HTTPS to update plugins and Treesitter parsers.
---@type boolean
settings["use_ssh"] = true

-- Set to false if you don't use copilot
---@type boolean
settings["use_copilot"] = true

-- Default secret source for AI adapters. Set this to an environment variable
-- Examples:
--   "AI_API_KEY"
-- Recommended way of setting this environment variable, e.g.:
-- export AI_API_KEY=$(rbw get --field "API key" opencode\ go)
---@type string
settings["ai_api_key"] = "AI_API_KEY"

-- Shared AI adapters for CodeCompanion and OpenAI-compatible edit prediction.
-- Adapter `api_key` is optional; when omitted, `ai_api_key` is used.
---@type table<string, table>
settings["ai_adapters"] = {
	openrouter = {
		type = "openai-compatible",
		name = "OpenRouter",
		base_url = "https://openrouter.ai/api",
		chat_url = "/v1/chat/completions",
		models = {
			"moonshotai/kimi-k2:free",
			"qwen/qwen3-coder:free",
			"deepseek/deepseek-chat-v3-0324:free",
			"deepseek/deepseek-r1:free",
			"google/gemma-3-27b-it:free",
			"openai/codex-mini",
			"openai/gpt-4.1-mini",
			"google/gemini-2.5-flash-lite",
			"google/gemini-2.5-flash",
			"anthropic/claude-3.7-sonnet",
			"anthropic/claude-sonnet-4",
		},
		default_model = "moonshotai/kimi-k2:free",
		optional = {
			-- Disable thinking/reasoning for OpenRouter models if needed:
			-- reasoning = { effort = "none" },
		},
	},
	opencode = {
		type = "openai-compatible",
		name = "Opencode",
		base_url = "https://opencode.ai/zen/go",
		chat_url = "/v1/chat/completions",
		models = {
			"deepseek-v4-flash",
			"deepseek-v4-pro",
			"kimi-k2.6",
			"mimo-v2.5-pro",
			"glm-5.1",
		},
		default_model = "deepseek-v4-pro",
		optional = {
			-- Disable thinking for DeepSeek-compatible APIs if needed:
			-- thinking = { type = "disabled" },
		},
	},
	openai = {
		type = "builtin",
		adapter = "openai",
		name = "OpenAI",
		api_key = "OPENAI_API_KEY",
		models = { "gpt-4.1-mini", "gpt-5-mini" },
		default_model = "gpt-4.1-mini",
		optional = {
			-- Disable reasoning for OpenAI reasoning models if needed:
			-- reasoning_effort = "none",
		},
	},
}

-- Default CodeCompanion adapter. Must be a key in `ai_adapters`.
-- The hyphenated key `codecompanion-adapter` is also accepted in user settings.
---@type string
settings["codecompanion_adapter"] = "openrouter"

-- Completion prediction backend.
-- Valid values: `copilot`, `oai-compatible`.
-- The hyphenated key `edit-prediction-source` is also accepted in user settings.
---@type "copilot"|"oai-compatible"
settings["edit_prediction_source"] = "oai-compatible"

-- Default adapter for OpenAI-compatible edit prediction. Must be a key in `ai_adapters`.
-- The hyphenated key `pred-adapter` is also accepted in user settings.
---@type string
settings["pred_adapter"] = "opencode"

-- Model used by OpenAI-compatible Minuet completion prediction.
-- The hyphenated key `pred-model` is also accepted in user settings.
---@type string
settings["pred_model"] = "deepseek-v4-flash"

-- Extra OpenAI-compatible request parameters for Minuet completion prediction.
-- The hyphenated key `pred-optional-params` is also accepted in user settings.
--
-- Examples for disabling thinking/reasoning:
--   OpenRouter: { reasoning = { effort = "none" } }
--   OpenCode go: { thinking = { type = "disabled" } }
--   OpenAI reasoning APIs: { reasoning_effort = "none" }
--
-- You may also set completion limits here, for example:
--   { max_tokens = 128 }
---@type table
settings["pred_optional_params"] = {
	top_p = 0.9,
	max_tokens = 128,
	{ thinking = { type = "disabled" } },
}

-- Set it to false if there is no need to format on save.
---@type boolean
settings["format_on_save"] = true

-- Set format timeout here (in ms).
---@type number
settings["format_timeout"] = 1500

-- Set it to false if the notification after formatting is annoying.
---@type boolean
settings["format_notify"] = true

-- Set it to true if you prefer formatting ONLY the *changed lines* as defined by your version control system.
-- NOTE: This entry will only be respected if:
--  > The buffer to be formatted is under version control (Git or Mercurial);
--  > Any of the server attached to that buffer supports |DocumentRangeFormattingProvider| server capability.
-- Otherwise Neovim would fall back to format the whole buffer, and a warning will be issued.
---@type boolean
settings["format_modifications_only"] = false

-- Filetypes in this list will skip lsp formatting if rhs is true.
---@type table<string, boolean>
settings["formatter_block_list"] = {
	lua = false, -- example
}

-- Servers in this list will skip setting formatting capabilities if rhs is true.
---@type table<string, boolean>
settings["server_formatting_block_list"] = {
	lua_ls = true,
	ts_ls = true,
	ruff = false, -- set to false to enable ruff formatting, see discussion #1485
	clangd = true,
}

-- Directories where formatting on save is disabled.
-- NOTE: Strings may contain regular expressions (vim regex). |regexp|
-- NOTE: Directories are automatically normalized using |vim.fs.normalize()|.
---@type string[]
settings["format_disabled_dirs"] = {
	-- Example
	"~/format_disabled_dir",
}

-- Set to false to disable virtual lines for diagnostics.
-- You can still view diagnostics using trouble.nvim (`<leader>ld`).
---@type boolean
settings["diagnostics_virtual_lines"] = true

-- Set it to one of the values below if you want to change the visible severity level of lsp diagnostics.
-- Priority: `Error` > `Warning` > `Information` > `Hint`.
--  > e.g. if you set this option to `Warning`, only lsp warnings and errors will be shown.
-- NOTE: This entry only works when `diagnostics_virtual_lines` is true.
---@type "ERROR"|"WARN"|"INFO"|"HINT"
settings["diagnostics_level"] = "HINT"

-- Set the plugins to disable here.
-- Example: "Some-User/A-Repo"
---@type string[]
settings["disabled_plugins"] = {}

-- Set it to false if you don't use nvim to open big files.
---@type boolean
settings["load_big_files_faster"] = true

-- Change the colors of the global palette here.
-- Settings will complete their replacement at initialization.
-- Parameters will be automatically completed as you type.
-- Example: { sky = "#04A5E5" }
---@type palette[]
settings["palette_overwrite"] = {}

-- Set the colorscheme to use here.
-- Available values are: `catppuccin`, `catppuccin-latte`, `catppucin-mocha`, `catppuccin-frappe`, `catppuccin-macchiato`.
---@type string
settings["colorscheme"] = "catppuccin"

-- Set it to true if your terminal has transparent background.
---@type boolean
settings["transparent_background"] = false

-- Set background color to use here.
-- Useful if you would like to use a colorscheme that has a light and dark variant like `edge`.
-- Valid values are: `dark`, `light`.
---@type "dark"|"light"
settings["background"] = "dark"

-- Set the command for handling external URLs here. The executable must be available on your $PATH.
-- This entry is IGNORED on Windows and macOS, which have their default handlers builtin.
---@type string
settings["external_browser"] = "chrome-cli open"

-- Set the language servers that will be installed during bootstrap here.
-- check the below link for all the supported LSPs:
-- https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/server_configurations
---@type string[]
settings["lsp_deps"] = {
	--"bashls",
	--"clangd",
	--"html",
	--"jsonls",
	--"lua_ls",
	--"pylsp",
	"gopls",
	"ruff",
	"pyrefly",
}

-- Set the general-purpose servers that will be installed during bootstrap here.
-- Check the below link for all supported sources.
-- in `code_actions`, `completion`, `diagnostics`, `formatting`, `hover` folders:
-- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins
---@type string[]
settings["null_ls_deps"] = {
	"clang_format",
	"gofumpt",
	"goimports",
	-- "prettier",
	"shfmt",
	"stylua",
	"vint",
}

-- Debug Adapter Protocol (DAP) clients to install and configure during bootstrap.
-- Supported DAPs: https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
---@type string[]
settings["dap_deps"] = {
	"codelldb", -- C-Family
	"delve", -- Go
	"python", -- Python (debugpy)
}

-- Treesitter parsers to install during bootstrap.
-- Full list: https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
---@type string[]
settings["treesitter_deps"] = {
	"bash",
	"c",
	"cpp",
	"css",
	"go",
	"gomod",
	"html",
	"javascript",
	"json",
	"jsonc",
	"latex",
	"lua",
	"make",
	"markdown",
	"markdown_inline",
	"python",
	"rust",
	"typescript",
	"vimdoc",
	"vue",
	"yaml",
}

-- Set the options for neovim's gui clients like `neovide` and `neovim-qt` here.
-- NOTE: Currently, only the following options related to the GUI are supported. Other entries will be IGNORED.
---@type { font_name: string, font_size: number }
settings["gui_config"] = {
	font_name = "JetBrainsMono Nerd Font",
	font_size = 12,
}

-- Specific settings for `neovide`.
-- Remove the `neovide_` prefix (with trailing underscore) from all entries below.
-- Supported entries: https://neovide.dev/configuration.html
---@type table<string, boolean|number|string>
settings["neovide_config"] = {
	no_idle = false,
	input_ime = true,
	fullscreen = true,
	padding_left = 8,
	confirm_quit = true,
	cursor_vfx_mode = "torpedo",
	cursor_trail_size = 0.05,
	cursor_antialiasing = true,
	hide_mouse_when_typing = true,
	input_macos_alt_is_meta = false,
	cursor_animation_length = 0.03,
	cursor_vfx_particle_speed = 20.0,
	cursor_vfx_particle_density = 5.0,
}

-- Set the dashboard startup image here
-- You can generate the ascii image using: https://github.com/TheZoraiz/ascii-image-converter
-- More info: https://github.com/ayamir/nvimdots/wiki/Issues#change-dashboard-startup-image
---@type string[]
settings["dashboard_image"] = {
	[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⣠⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣡⣾⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣟⠻⣿⣿⣿⣿⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⣿⣿⡿⢫⣷⣿⣿⣿⣿⣿⣿⣿⣾⣯⣿⡿⢧⡚⢷⣌⣽⣿⣿⣿⣿⣿⣶⡌⣿⣿⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⣿⣿⠇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣇⣘⠿⢹⣿⣿⣿⣿⣿⣻⢿⣿⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⡇⣿⣿⣿⣿⣿⣿⣿⣿⡟⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣻⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⣿⡇⠀⣬⠏⣿⡇⢻⣿⣿⣿⣿⣿⣿⣿⣷⣼⣿⣿⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⢻⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⣿⠀⠈⠁⠀⣿⡇⠘⡟⣿⣿⣿⣿⣿⣿⣿⣿⡏⠿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣇⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⡏⠀⠀⠐⠀⢻⣇⠀⠀⠹⣿⣿⣿⣿⣿⣿⣩⡶⠼⠟⠻⠞⣿⡈⠻⣟⢻⣿⣿⣿⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢿⠀⡆⠀⠘⢿⢻⡿⣿⣧⣷⢣⣶⡃⢀⣾⡆⡋⣧⠙⢿⣿⣿⣟⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⡥⠂⡐⠀⠁⠑⣾⣿⣿⣾⣿⣿⣿⡿⣷⣷⣿⣧⣾⣿⣿⣿⣿⣿⣿⣿]],
	[[⣿⣿⡿⣿⣍⡴⠆⠀⠀⠀⠀⠀⠀⠀⠀⣼⣄⣀⣷⡄⣙⢿⣿⣿⣿⣿⣯⣶⣿⣿⢟⣾⣿⣿⢡⣿⣿⣿⣿⣿]],
	[[⣿⡏⣾⣿⣿⣿⣷⣦⠀⠀⠀⢀⡀⠀⠀⠠⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⣡⣾⣿⣿⢏⣾⣿⣿⣿⣿⣿]],
	[[⣿⣿⣿⣿⣿⣿⣿⣿⡴⠀⠀⠀⠀⠀⠠⠀⠰⣿⣿⣿⣷⣿⠿⠿⣿⣿⣭⡶⣫⠔⢻⢿⢇⣾⣿⣿⣿⣿⣿⣿]],
	[[⣿⣿⣿⡿⢫⣽⠟⣋⠀⠀⠀⠀⣶⣦⠀⠀⠀⠈⠻⣿⣿⣿⣾⣿⣿⣿⣿⡿⣣⣿⣿⢸⣾⣿⣿⣿⣿⣿⣿⣿]],
	[[⡿⠛⣹⣶⣶⣶⣾⣿⣷⣦⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠉⠛⠻⢿⣿⡿⠫⠾⠿⠋⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
	[[⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⡆⣠⢀⣴⣏⡀⠀⠀⠀⠉⠀⠀⢀⣠⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
	[[⠿⠛⠛⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣯⣟⠷⢷⣿⡿⠋⠀⠀⠀⠀⣵⡀⢠⡿⠋⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⢿⣿⣿⠂⠀⠀⠀⠀⠀⢀⣽⣿⣿⣿⣿⣿⣿⣿⣍⠛⠿⣿⣿⣿⣿⣿⣿]],
}

-- Set it to false if you don't use AI chat functionality.
---@type boolean
settings["use_chat"] = true

-- Set the language to use for AI chat response here.
--- @type string
settings["chat_lang"] = "Chinese"

-- Set the search backend here.
-- `telescope` is fine for most use cases.
-- `fzf` is faster for large repos but needs the `fzf` binary in $PATH.
-- If missing, errors are expected until the binary is installed.
---@type "telescope"|"fzf"
settings["search_backend"] = "telescope"

-- Set to false to disable LSP inlay hints.
---@type boolean
settings["lsp_inlayhints"] = false

return require("modules.utils").extend_config(settings, "user.settings")
