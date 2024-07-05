local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cmd = bind.map_cmd

return {
	["n|gt"] = map_cmd("<ESC><Cmd>GoTestFunc -v --count=1 -F<CR>"):with_noremap():with_silent(),
	["n|<A-e>"] = map_cr("Trouble lsp_references"):with_noremap():with_silent(),
	["n|<A-t>"] = map_cr("GoPkgOutline"):with_noremap():with_silent(),
	["n|<A-c>"] = map_cr("GoTermClose"):with_noremap():with_silent(),
}
