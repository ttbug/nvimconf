return function()
	require("fittencode").setup({
		disable_specific_inline_completion = {
			-- Disable auto-completion for some specific file suffixes by entering them below
			-- For example, `suffixes = {'lua', 'cpp'}`
			suffixes = {},
		},
		inline_completion = {
			-- Enable inline code completion.
			enable = true,
		},
		-- Set the mode of the completion.
		-- Available options:
		-- - 'inline' (default)
		-- - 'source'
		completion_mode = "inline",
		use_default_keymaps = true,
		log = {
			level = vim.log.levels.WARN,
		},
	})
end
