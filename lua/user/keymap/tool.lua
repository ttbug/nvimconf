local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

return {
	["n|<C-n>"] = false,

	-- json 格式化快捷键
	["n|<leader>j"] = map_cr("%!python -m json.tool --no-ensure-ascii"):with_noremap():with_silent(),
	["n|<leader>pp"] = map_cu("Legendary"):with_silent():with_noremap(),
	["n|<leader>pf"] = map_cu("Legendary functions"):with_silent():with_noremap(),
	["n|<F4>"] = map_cr("NvimTreeToggle"):with_noremap():with_silent():with_desc("filetree: Toggle"),
	-- Plugin: edgy
	--["n|<F4>"] = map_callback(function()
	--		require("edgy").toggle("left")
	--	end)
	--	:with_noremap()
	--	:with_silent()
	--	:with_desc("filetree: Toggle"),

	-- todo-comments
	["n|<leader>tt"] = map_cu("TodoTelescope"):with_silent():with_noremap():with_desc("todo list"),

	-- Plugin floaterm
	["n|<F12>"] = map_cr([[execute v:count . "ToggleTerm direction=float"]]):with_noremap():with_silent(),
	["i|<F12>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=float<CR>"):with_noremap():with_silent(),
	["t|<F12>"] = map_cmd("<Esc><Cmd>ToggleTerm<CR>"):with_noremap():with_silent(),
}
