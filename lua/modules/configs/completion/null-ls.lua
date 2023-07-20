return function()
	local null_ls = require("null-ls")
	local mason_null_ls = require("mason-null-ls")
	local btns = null_ls.builtins

	-- Please set additional flags for the supported servers here
	-- Don't specify any config here if you are using the default one.
	local sources = {
		btns.formatting.clang_format.with({
			filetypes = { "c", "cpp" },
			extra_args = require("completion.formatters.clang_format"),
		}),
		btns.formatting.prettier.with({
			filetypes = {
				"vue",
				"typescript",
				"javascript",
				"typescriptreact",
				"javascriptreact",
				"yaml",
				"html",
				"css",
				"scss",
				"sh",
				"markdown",
			},
		}),
		btns.formatting.gofumpt,
		btns.formatting.goimports,
		btns.formatting.rustfmt,
	}

	--local warn_TODO = {
	--	name = "no-todo",
	--	method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
	--	-- stylua: ignore start
	--	filetypes = {
	--		"go",
	--		"py",
	--		"lua",
	--		"sh",
	--		"java",
	--		"js",
	--		"ts",
	--		"tsx",
	--		"jsx",
	--		"html",
	--		"css",
	--		"scss",
	--		"json",
	--		"yaml",
	--		"toml",
	--	},
	--	generator = {
	--		fn = function(params)
	--			local diag = {}
	--			-- sources have access to a params object
	--			-- containing info about the current file and editor state
	--			for i, line in ipairs(params.content) do
	--				if line then
	--					local f = vim.fn.matchstrpos(line, "\\v(todo)|(fixme)|(xxx)|(\\<fix\\>)|(hack)")
	--					local col, end_col = f[2], f[3]
	--					if col and end_col >= 0 then
	--						vim.notify(
	--							string.format("found todo in line %d", i),
	--							vim.log.levels.INFO,
	--							{ title = "TODO Checker!" }
	--						)
	--						-- lprint("found", col, end_col)
	--						-- null-ls fills in undefined positions
	--						-- and converts source diagnostics into the required format
	--						table.insert(diag, {
	--							row = i,
	--							col = col,
	--							end_col = end_col + 1,
	--							source = "no-todo",
	--							message = "just do it",
	--							severity = vim.diagnostic.severity.INFO,
	--						})
	--					end
	--				end
	--			end
	--			return diag
	--		end,
	--	},
	--}
	-- stylua: ignore end
	-- table.insert(sources, warn_TODO)
	if vim.o.ft == "go" then
		table.insert(sources, require("go.null_ls").gotest())
		table.insert(sources, require("go.null_ls").golangci_lint())
		table.insert(sources, require("go.null_ls").gotest_action())
	end

	null_ls.setup({
		border = "rounded",
		debug = false,
		log_level = "warn",
		update_in_insert = false,
		sources = sources,
	})

	mason_null_ls.setup({
		ensure_installed = require("core.settings").null_ls_deps,
		automatic_installation = false,
		automatic_setup = true,
		handlers = {},
	})

	-- Setup usercmd to register/deregister available source(s)
	local function _gen_completion()
		local sources_cont = null_ls.get_source({
			filetype = vim.api.nvim_get_option_value("filetype", { scope = "local" }),
		})
		local completion_items = {}
		for _, server in pairs(sources_cont) do
			table.insert(completion_items, server.name)
		end
		return completion_items
	end
	vim.api.nvim_create_user_command("NullLsToggle", function(opts)
		if vim.tbl_contains(_gen_completion(), opts.args) then
			null_ls.toggle({ name = opts.args })
		else
			vim.notify(
				string.format("[Null-ls] Unable to find any registered source named [%s].", opts.args),
				vim.log.levels.ERROR,
				{ title = "Null-ls Internal Error" }
			)
		end
	end, {
		nargs = 1,
		complete = _gen_completion,
	})

	require("completion.formatting").configure_format_on_save()
end
