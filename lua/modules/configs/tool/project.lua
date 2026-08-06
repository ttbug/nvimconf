return function()
	require("modules.utils").load_plugin("project", {
		manual_mode = false,
		lsp = { enabled = true, ignore = { "null-ls", "copilot" } },
		patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
		exclude_dirs = {},
		show_hidden = false,
		silent_chdir = true,
		scope_chdir = "global",
		options = {
			history = {
				save_dir = vim.fn.stdpath("data"),
			},
		},
	})
end
