local bind = require("keymap.bind")
local map_cr = bind.map_cr

return {
	["n|<A-S-j>"] = false,
	["n|<A-S-k>"] = false,
	["n|<C-l>"] = map_cr("BufferLineMoveNext"):with_noremap():with_silent():with_desc("buffer: Move current to next"),
	["n|<C-k>"] = map_cr("BufferLineMovePrev"):with_noremap():with_silent():with_desc("buffer: Move current to prev"),
}
