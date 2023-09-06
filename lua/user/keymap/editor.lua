local bind = require("keymap.bind")
local map_cr = bind.map_cr

return {
	["n|<C-^>"] = map_cr(":bd"):with_noremap():with_silent(),
}
