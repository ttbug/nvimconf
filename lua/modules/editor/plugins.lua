local editor = {}
local conf = require('modules.editor.config')

editor['junegunn/vim-easy-align'] = {opt = true, cmd = 'EasyAlign'}
editor["RRethy/vim-illuminate"] = {
	event = "BufReadPost",
    config = conf.illuminate,
}
editor["terrortylor/nvim-comment"] = {
	opt = false,
    config = conf.nvim_comment,
}
editor['nvim-treesitter/nvim-treesitter'] = {
    opt = true,
    run = ':TSUpdate',
    event = 'BufReadPost',
    config = conf.nvim_treesitter
}
editor['nvim-treesitter/nvim-treesitter-textobjects'] = {
    opt = true,
    after = 'nvim-treesitter'
}
editor['p00f/nvim-ts-rainbow'] = {
    opt = true,
    after = 'nvim-treesitter',
    event = 'BufReadPost'
}
editor['JoosepAlviste/nvim-ts-context-commentstring'] = {
    opt = true,
    after = 'nvim-treesitter'
}
editor["mfussenegger/nvim-ts-hint-textobject"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor['windwp/nvim-ts-autotag'] = {
    opt = true,
    after = "nvim-treesitter",
    config = conf.autotag
}
editor['andymass/vim-matchup'] = {
    opt = true,
    after = 'nvim-treesitter',
    config = conf.matchup
}
editor["rhysd/accelerated-jk"] = { opt = true, event = "BufWinEnter" }
editor["hrsh7th/vim-eft"] = { opt = true, event = "BufReadPost" }
editor['romainl/vim-cool'] = {
    opt = true,
    event = {'CursorMoved', 'InsertEnter'}
}

editor["phaazon/hop.nvim"] = {
	opt = true,
	branch = "v1",
	event = "BufReadPost",
    config = conf.hop,
}
editor['easymotion/vim-easymotion'] = {opt = true, config = conf.easymotion}
editor['karb94/neoscroll.nvim'] = {
    opt = true,
    event = "WinScrolled",
    config = conf.neoscroll
}
editor['akinsho/toggleterm.nvim'] = {
    opt = true,
    event = 'BufReadPost',
    config = conf.toggleterm
}
--editor["vimlab/split-term.vim"] = { opt = true, cmd = { "Term", "VTerm" } }
editor['norcalli/nvim-colorizer.lua'] = {
    opt = true,
    event = 'BufRead',
    config = conf.nvim_colorizer
}
--editor["numtostr/FTerm.nvim"] = { opt = true, event = "BufRead" }
editor['rmagatti/auto-session'] = {
    opt = true,
    cmd = {'SaveSession', 'RestoreSession', 'DeleteSession'},
    config = conf.auto_session
}
--editor['jdhao/better-escape.vim'] = {
--    opt = true,
--    event = 'InsertEnter'
--}

editor["max397574/better-escape.nvim"] = {
	opt = true,
	event = "BufReadPost",
	config = conf.better_escape,
}

editor['rcarriga/nvim-dap-ui'] = {
    opt = false,
    config = conf.dapui,
    requires = {
        {'mfussenegger/nvim-dap', config = conf.dap}, {
            'Pocco81/dap-buddy.nvim',
            opt = true,
            cmd = {'DIInstall', 'DIUninstall', 'DIList'},
            config = conf.dapinstall
        }
    }
}
--editor["tpope/vim-fugitive"] = { opt = true, cmd = { "Git", "G" } }
editor["famiu/bufdelete.nvim"] = {
	opt = true,
	cmd = { "Bdelete", "Bwipeout", "Bdelete!", "Bwipeout!" },
}

editor["edluffy/specs.nvim"] = {
	opt = true,
	event = "CursorMoved",
	config = conf.specs,
}
editor["abecodes/tabout.nvim"] = {
	opt = true,
	event = "InsertEnter",
	wants = "nvim-treesitter",
	after = "nvim-cmp",
	config = conf.tabout,
}

editor['theHamsta/nvim-dap-virtual-text'] = {
    opt = true,
    cmd = {'DapVirtualTextEnable', 'DapVirtualTextDisable'},
    config = conf.dap_virtual_text
}
editor["sindrets/diffview.nvim"] = {
	opt = true,
	cmd = { "DiffviewOpen" },
}

editor["luukvbaal/stabilize.nvim"] = {
	opt = true,
	event = "BufReadPost",
}

return editor
