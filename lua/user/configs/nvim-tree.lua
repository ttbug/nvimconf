return {
	filters = {
		dotfiles = true,
		custom = { ".DS_Store", ".git", ".vscode", ".idea" },
		exclude = {},
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
}
