return function()
	require("modules.utils").load_plugin("go", {
		fillstruct = "gopls",
		lsp_keymaps = false,
		dap_debug_vt = true,
		dap_debug_gui = true,
		test_runner = "go", -- richgo, go test, richgo, dlv, ginkgo
		dap_debug = true,
		dap_debug_keymap = false,
		icons = false,
		gofmt = "gopls",
		goimports = "gopls",
		lsp_gofumpt = true,
		lsp_inlay_hints = { enable = false },
		run_in_floaterm = true,
		trouble = true,
		lsp_codelens = false,
		gopls_remote_auto = true,
		diagnostic = { -- set diagnostic to false to disable vim.diagnostic setup
			hdlr = false, -- hook lsp diag handler and send diag to quickfix
			underline = true,
			-- virtual text setup
			virtual_text = { spacing = 0, prefix = "■" },
			signs = true,
			update_in_insert = false,
		},
		lsp_cfg = require("modules.configs.completion.servers.gopls"),
	})
end
