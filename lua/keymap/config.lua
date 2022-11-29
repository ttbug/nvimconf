local vim = vim

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.enhance_jk_move = function(key)
	local map = key == "j" and "<Plug>(accelerated_jk_gj)" or "<Plug>(accelerated_jk_gk)"
	return t(map)
end

_G.enhance_ft_move = function(key)
	local map = {
		[";"] = "<Plug>(clever-f-repeat-forward)",
		[","] = "<Plug>(clever-f-repeat-back)",
	}
	return t(map[key])
end

_G.enhance_align = function(key)
	--vim.cmd([[packadd vim-easy-align]])
	vim.api.nvim_command([[packadd vim-easy-align]])
	local map = { ["nga"] = "<Plug>(EasyAlign)", ["xga"] = "<Plug>(EasyAlign)" }
	return t(map[key])
end
