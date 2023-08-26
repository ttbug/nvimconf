local bind = require("keymap.bind")
local map_cr = bind.map_cr

return {
	["n|<C-l>"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent(),
	["n|<C-k>"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent(),
}
