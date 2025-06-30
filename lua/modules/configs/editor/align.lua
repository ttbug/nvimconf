return function()
	require("modules.utils").load_plugin("mini.align", {
		-- Whether to disable showing non-error feedback
		silent = true,
		-- Module mappings. Use `''` (empty string) to disable one.
		mappings = {
			start = "gea",
			start_with_preview = "geA",
		},
	})
end
