return function()
	local icons = { aichat = require("modules.utils.icons").get("aichat", true) }
	local settings = require("core.settings")
	local ai = require("modules.utils.ai")
	local chat_lang = settings.chat_lang
	local current_model = ai.get_codecompanion_default_model()
	local codecompanion_adapter = ai.get_codecompanion_adapter_name()
	local http_adapters = {}

	for name, adapter_config in pairs(settings.ai_adapters or {}) do
		local adapter_key = name
		local adapter = adapter_config

		http_adapters[adapter_key] = function()
			local adapter_name = adapter.adapter
				or (adapter.type == "openai-compatible" and "openai_compatible")
				or adapter_key
			local models = ai.get_adapter_models(adapter)
			local opts = {
				env = {
					api_key = ai.get_adapter_api_key(adapter),
				},
				schema = {
					model = {
						default = vim.g.current_chat_model or ai.get_adapter_default_model(adapter),
					},
				},
			}

			if #models > 0 then
				opts.schema.model.choices = models
			end

			if adapter.type == "openai-compatible" then
				opts.env.url = adapter.base_url
				opts.env.chat_url = adapter.chat_url or "/v1/chat/completions"
			end

			return require("codecompanion.adapters").extend(adapter_name, opts)
		end
	end
	vim.g.current_chat_model = current_model

	require("modules.utils").load_plugin("codecompanion", {
		http = {
			opts = {
				language = chat_lang,
			},
		},
		strategies = {
			chat = {
				adapter = codecompanion_adapter,
				roles = {
					llm = function(adapter)
						return icons.aichat.Copilot .. "CodeCompanion (" .. adapter.formatted_name .. ")"
					end,
					user = icons.aichat.Me .. "Me",
				},
				keymaps = {
					submit = {
						modes = { n = "<CR>" },
						description = "Submit",
						callback = function(chat)
							chat:apply_model(current_model)
							chat:submit()
						end,
					},
				},
			},
			inline = {
				adapter = codecompanion_adapter,
			},
			cmd = {
				adapter = codecompanion_adapter,
			},
		},
		adapters = {
			http = http_adapters,
		},
		display = {
			diff = {
				enabled = true,
				close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
				layout = "vertical", -- vertical|horizontal split for default provider
				opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
				provider = "default", -- default|mini_diff
			},
			chat = {
				window = {
					layout = "vertical", -- float|vertical|horizontal|buffer
					position = "right", -- left|right|top|bottom (nil will default depending on vim.opt.plitright|vim.opt.splitbelow)
					border = "single",
					width = 0.25,
					relative = "editor",
					full_height = true, -- when set to false, vsplit will be used to open the chat buffer vs. botright/topleft vsplit
				},
			},
		},
		extensions = {
			history = {
				enabled = true,
				opts = {
					-- Keymap to open history from chat buffer (default: gh)
					keymap = "gh",
					-- Automatically generate titles for new chats
					auto_generate_title = true,
					---On exiting and entering neovim, loads the last chat on opening chat
					continue_last_chat = false,
					---When chat is cleared with `gx` delete the chat from history
					delete_on_clearing_chat = false,
					-- Picker interface ("telescope", "snacks" or "default")
					picker = "telescope",
					---Enable detailed logging for history extension
					enable_logging = false,
					---Directory path to save the chats
					dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
					-- Save all chats by default
					auto_save = true,
					-- Keymap to save the current chat manually
					save_chat_keymap = "sc",
					-- Number of days after which chats are automatically deleted (0 to disable)
					expiration_days = 0,
				},
			},
		},
	})
end
