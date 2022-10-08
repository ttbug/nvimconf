local config = {}

function config.nvim_lsp()
	require("modules.completion.lsp")
end
--function config.lightbulb()
--	vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
--end
--
--function config.aerial()
--	require("aerial").setup({})
--end
function config.lspsaga()
	local function set_sidebar_icons()
		-- Set icons for sidebar.
		local diagnostic_icons = {
			Error = " ",
			Warn = " ",
			Info = " ",
			Hint = " ",
		}
		for type, icon in pairs(diagnostic_icons) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl })
		end
	end

	local function get_palette()
		if vim.g.colors_name == "catppuccin" then
			-- If the colorscheme is catppuccin then use the palette.
			return require("catppuccin.palettes").get_palette()
		else
			-- Default behavior: return lspsaga's default palette.
			local palette = require("lspsaga.lspkind").colors
			palette.peach = palette.orange
			palette.flamingo = palette.orange
			palette.rosewater = palette.yellow
			palette.mauve = palette.violet
			palette.sapphire = palette.blue
			palette.maroon = palette.orange

			return palette
		end
	end

	set_sidebar_icons()

	local colors = get_palette()

	require("lspsaga").init_lsp_saga({
		diagnostic_header = { " ", " ", "  ", " " },
		custom_kind = {
			File = { " ", colors.rosewater },
			Module = { " ", colors.blue },
			Namespace = { " ", colors.blue },
			Package = { " ", colors.blue },
			Class = { "ﴯ ", colors.yellow },
			Method = { " ", colors.blue },
			Property = { "ﰠ ", colors.teal },
			Field = { " ", colors.teal },
			Constructor = { " ", colors.sapphire },
			Enum = { " ", colors.yellow },
			Interface = { " ", colors.yellow },
			Function = { " ", colors.blue },
			Variable = { " ", colors.peach },
			Constant = { " ", colors.peach },
			String = { " ", colors.green },
			Number = { " ", colors.peach },
			Boolean = { " ", colors.peach },
			Array = { " ", colors.peach },
			Object = { " ", colors.yellow },
			Key = { " ", colors.red },
			Null = { "ﳠ ", colors.yellow },
			EnumMember = { " ", colors.teal },
			Struct = { " ", colors.yellow },
			Event = { " ", colors.yellow },
			Operator = { " ", colors.sky },
			TypeParameter = { " ", colors.maroon },
			-- ccls-specific icons.
			TypeAlias = { " ", colors.green },
			Parameter = { " ", colors.blue },
			StaticMethod = { "ﴂ ", colors.peach },
			Macro = { " ", colors.red },
		},
		symbol_in_winbar = {
			click_support = function(node, clicks, button, modifiers)
				-- To see all avaiable details: vim.pretty_print(node)
				local st = node.range.start
				local en = node.range["end"]
				if button == "l" then
					if clicks == 2 then
					-- double left click to do nothing
					else -- jump to node's starting line+char
						vim.fn.cursor(st.line + 1, st.character + 1)
					end
				elseif button == "r" then
					if modifiers == "s" then
						print("lspsaga") -- shift right click to print "lspsaga"
					end -- jump to node's ending line+char
					vim.fn.cursor(en.line + 1, en.character + 1)
				elseif button == "m" then
					-- middle click to visual select node
					vim.fn.cursor(st.line + 1, st.character + 1)
					--vim.cmd("normal v")
                    vim.api.nvim_command([[normal v]])
					vim.fn.cursor(en.line + 1, en.character + 1)
				end
			end,
		},
	})

	-- Example:
	local function get_file_name(include_path)
		local file_name = require("lspsaga.symbolwinbar").get_file_name()
		if vim.fn.bufname("%") == "" then
			return ""
		end
		if include_path == false then
			return file_name
		end
		-- Else if include path: ./lsp/saga.lua -> lsp > saga.lua
		local sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"
		local path_list = vim.split(string.gsub(vim.fn.expand("%:~:.:h"), "%%", ""), sep)
		local file_path = ""
		for _, cur in ipairs(path_list) do
			file_path = (cur == "." or cur == "~") and ""
				or file_path .. cur .. " " .. "%#LspSagaWinbarSep#>%*" .. " %*"
		end
		return file_path .. file_name
	end

	local function config_winbar_or_statusline()
		local exclude = {
			["terminal"] = true,
			["toggleterm"] = true,
			["prompt"] = true,
			["NvimTree"] = true,
			["help"] = true,
		} -- Ignore float windows and exclude filetype
		if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
			vim.wo.winbar = ""
		else
			local ok, lspsaga = pcall(require, "lspsaga.symbolwinbar")
			local sym
			if ok then
				sym = lspsaga.get_symbol_node()
			end
			local win_val = ""
			win_val = get_file_name(true) -- set to true to include path
			if sym ~= nil then
				win_val = win_val .. sym
			end
			vim.wo.winbar = win_val
		end
	end

	local events = { "BufEnter", "BufWinEnter", "CursorMoved" }

	vim.api.nvim_create_autocmd(events, {
		pattern = "*",
		callback = function()
			config_winbar_or_statusline()
		end,
	})

	vim.api.nvim_create_autocmd("User", {
		pattern = "LspsagaUpdateSymbol",
		callback = function()
			config_winbar_or_statusline()
		end,
	})
end

function config.cmp()
	-- vim.cmd([[packadd cmp-tabnine]])
	local t = function(str)
		return vim.api.nvim_replace_termcodes(str, true, true, true)
	end

	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	local border = function(hl)
		return {
			{ "╭", hl },
			{ "─", hl },
			{ "╮", hl },
			{ "│", hl },
			{ "╯", hl },
			{ "─", hl },
			{ "╰", hl },
			{ "│", hl },
		}
	end

	local cmp_window = require("cmp.utils.window")

	cmp_window.info_ = cmp_window.info
	cmp_window.info = function(self)
		local info = self:info_()
		info.scrollable = false
		return info
	end

	local compare = require("cmp.config.compare")
	local lspkind = require("lspkind")
	local cmp = require("cmp")

	cmp.setup({
		window = {
			completion = {
				border = border("CmpBorder"),
				winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
			},
			documentation = {
				border = border("CmpDocBorder"),
			},
		},
		sorting = {
			priority_weight = 2,
			comparators = {
				require("copilot_cmp.comparators").prioritize,
				require("copilot_cmp.comparators").score,
				-- require("cmp_tabnine.compare"),
				compare.offset,
				compare.exact,
				compare.score,
				require("cmp-under-comparator").under,
				compare.kind,
				compare.sort_text,
				compare.length,
				compare.order,
			},
		},
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
				ellipsis_char = "...",
				symbol_map = { Copilot = "" },
			}),
		},
		-- You can set mappings if you want
		mapping = cmp.mapping.preset.insert({
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-e>"] = cmp.mapping.close(),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif require("luasnip").expand_or_jumpable() then
					vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif require("luasnip").jumpable(-1) then
					vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		-- You should specify your *installed* sources.
		sources = {
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "luasnip" },
			{ name = "path" },
			{ name = "spell" },
			{ name = "tmux" },
			{ name = "orgmode" },
			{ name = "buffer" },
			{ name = "latex_symbols" },
			{ name = "copilot" },
			-- { name = "cmp_tabnine" },
		},
	})
end

function config.luasnip()
	--vim.o.runtimepath = vim.o.runtimepath .. "," .. os.getenv("HOME") .. "/.config/nvim/my-snippets/,"
    local snippet_path = os.getenv("HOME") .. "/.config/nvim/my-snippets/"
	if not vim.tbl_contains(vim.opt.rtp:get(), snippet_path) then
		vim.opt.rtp:append(snippet_path)
	end
	require("luasnip").config.set_config({
		history = true,
		updateevents = "TextChanged,TextChangedI",
		delete_check_events = "TextChanged,InsertLeave",
	})
	require("luasnip.loaders.from_lua").lazy_load()
	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_snipmate").lazy_load()
end

-- function config.tabnine()
--     local tabnine = require('cmp_tabnine.config')
--     tabnine:setup({max_line = 1000, max_num_results = 20, sort = true})
-- end

function config.autopairs()
	require("nvim-autopairs").setup({})

	-- If you want insert `(` after select function or method item
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	local cmp = require("cmp")
	--cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
	--cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"
	local handlers = require("nvim-autopairs.completion.handlers")
	cmp.event:on(
		"confirm_done",
		cmp_autopairs.on_confirm_done({
			filetypes = {
				-- "*" is a alias to all filetypes
				["*"] = {
					["("] = {
						kind = {
							cmp.lsp.CompletionItemKind.Function,
							cmp.lsp.CompletionItemKind.Method,
						},
						handler = handlers["*"],
					},
				},
				-- Disable for tex
				tex = false,
			},
		})
	)
end

--function config.bqf()
--	vim.cmd([[
--    hi BqfPreviewBorder guifg=#F2CDCD ctermfg=71
--    hi link BqfPreviewRange Search
--]])
--
--	require("bqf").setup({
--		auto_enable = true,
--		auto_resize_height = true, -- highly recommended enable
--		preview = {
--			win_height = 12,
--			win_vheight = 12,
--			delay_syntax = 80,
--			border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
--			should_preview_cb = function(bufnr, qwinid)
--				local ret = true
--				local bufname = vim.api.nvim_buf_get_name(bufnr)
--				local fsize = vim.fn.getfsize(bufname)
--				if fsize > 100 * 1024 then
--					-- skip file size greater than 100k
--					ret = false
--				elseif bufname:match("^fugitive://") then
--					-- skip fugitive buffer
--					ret = false
--				end
--				return ret
--			end,
--		},
--		-- make `drop` and `tab drop` to become preferred
--		func_map = {
--			drop = "q",
--			openc = "O",
--			split = "<C-s>",
--			tabdrop = "<C-t>",
--			tabc = "",
--			ptogglemode = "z,",
--		},
--		filter = {
--			fzf = {
--				action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
--				extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
--			},
--		},
--	})
--end

function config.mason_install()
	require("mason-tool-installer").setup({

		-- a list of all tools you want to ensure are installed upon
		-- start; they should be the names Mason uses for each tool
		ensure_installed = {
			-- you can turn off/on auto_update per tool
			--"editorconfig-checker",

			--"stylua",

			"black",

			--"prettier",
			--"eslint-lsp",

			--"bash-language-server",
			"shellcheck",
			"shfmt",

			--"vint",
		},

		-- if set to true this will check each tool for updates. If updates
		-- are available the tool will be updated.
		-- Default: false
		auto_update = false,

		-- automatically install / update on startup. If set to false nothing
		-- will happen on startup. You can use `:MasonToolsUpdate` to install
		-- tools and check for updates.
		-- Default: true
		run_on_start = false,
	})
end

return config
