return function()
	-- require("codegpt.config")
	vim.g["codegpt_openai_api_key"] = os.getenv("GROQ_API_KEY")
	vim.g["codegpt_api_provider"] = "groq"
	vim.g["codegpt_chat_completions_url"] = "https://api.groq.com/openai/v1"
	vim.g["codegpt_clear_visual_selection"] = true
	vim.g["codegpt_global_commands_defaults"] = {
		model = "Llama3-70b-8192",
		max_tokens = 4096,
		temperature = 0.6,
	}
end
