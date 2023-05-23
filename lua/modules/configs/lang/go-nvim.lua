return function()
	require("go").setup({
		fillstruct = "gopls",
		lsp_codelens = false, -- use navigator
		dap_debug = true,
		goimport = "gopls",
		dap_debug_vt = true,
		dap_debug_gui = true,
		test_runner = "go", -- richgo, go test, richgo, dlv, ginkgo
		run_in_floaterm = true, -- set to true to run in float window.
		lsp_document_formatting = false,
		luasnip = true,
		lsp_keymaps = false,
		dap_debug_keymap = false,
		icons = false,
		gofmt = "gopls",
		lsp_gofumpt = "true",
		lsp_inlay_hints = { enable = false },
		trouble = true,
		lsp_cfg = {
			flags = { debounce_text_changes = 500 },
			cmd = { "gopls", "-remote=auto" },
			settings = {
				gopls = {
					usePlaceholders = true,
					analyses = {
						nilness = true,
						shadow = true,
						unusedparams = true,
						unusewrites = true,
					},
					hints = {
						assignVariableTypes = true,
						compositeLiteralFields = true,
						constantValues = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
				},
			},
		},
	})
end
