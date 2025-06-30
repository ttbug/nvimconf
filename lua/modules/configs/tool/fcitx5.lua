return function()
	require("modules.utils").load_plugin("fcitx5", {
		log = "warn", -- string: log level (default: warn)
		remember_prior = true,
		define_autocmd = true,
	})
end
