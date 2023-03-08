local bind = require("keymap.bind")
local map_cr = bind.map_cr
-- local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
-- local map_callback = bind.map_callback

local plug_map = {
	-- go.nvim
	["n|gt"] = map_cmd("<ESC><Cmd>GoTestFunc -v -F<CR>"):with_noremap():with_silent(),
	["n|<A-e>"] = map_cr("TroubleToggle lsp_references"):with_noremap():with_silent(),
	["n|<A-t>"] = map_cr("GoPkgOutline"):with_noremap():with_silent(),
}

bind.nvim_load_mapping(plug_map)
