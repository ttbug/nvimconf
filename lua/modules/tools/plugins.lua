local tools = {}
local conf = require('modules.tools.config')

--tools["RishabhRD/popfix"] = {opt = false}
tools["aspeddro/gitui.nvim"] = {
    opt = false,
    config = function() require("gitui").setup {} end
}

tools["ttbug/tig.nvim"] = {
    opt = false,
    config = function() require("tig").setup{} end
}

tools['nvim-telescope/telescope.nvim'] = {
    opt = true,
    cmd = 'Telescope',
    config = conf.telescope,
    requires = {
        {'nvim-lua/popup.nvim', opt = true},
        {'nvim-lua/plenary.nvim', opt = true}
    }
}
tools['nvim-telescope/telescope-fzf-native.nvim'] = {
    opt = true,
    run = "make",
    after = 'telescope.nvim'
}

tools["nvim-telescope/telescope-file-browser.nvim"] = {
    opt = true,
    after = 'telescope.nvim'
}

tools['nvim-telescope/telescope-project.nvim'] = {
    opt = true,
    after = "telescope-fzf-native.nvim",
}
tools['nvim-telescope/telescope-frecency.nvim'] = {
    opt = true,
    after = 'telescope-project.nvim',
    requires = {{'tami5/sqlite.lua', opt = true}}
    --config = function() require("telescope").load_extension("frecency") end
}
--tools['thinca/vim-quickrun'] = {opt = true, cmd = {'QuickRun', 'Q'}}
tools["jvgrootveld/telescope-zoxide"] = { opt = true, after = "telescope-frecency.nvim" }
tools['michaelb/sniprun'] = {
    opt = true,
    run = 'bash ./install.sh',
    cmd = {"SnipRun", "'<,'>SnipRun"}
}
tools['folke/which-key.nvim'] = {
    opt = true,
    keys = ",",
    config = conf.which_key
}
tools['folke/trouble.nvim'] = {
    opt = true,
    cmd = {"Trouble", "TroubleToggle", "TroubleRefresh"},
    config = conf.trouble
}
tools['dstein64/vim-startuptime'] = {opt = true, cmd = "StartupTime"}
tools['gelguy/wilder.nvim'] = {
    event = "CmdlineEnter",
    -- run = ":UpdateRemotePlugins",
    config = conf.wilder,
    requires = {{'romgrk/fzy-lua-native', after = 'wilder.nvim'}}
}

-- tools['voldikss/vim-floaterm'] = {
--     opt = true,
--     cmd = {"FloatermNew", "FloatermToggle"},
--     config = conf.floaterm
-- }
-- tools['nathom/filetype.nvim'] = {opt = false}
tools['mg979/vim-visual-multi'] = {opt = false}
tools["famiu/bufdelete.nvim"] = {opt = true, cmd = {"Bdelete", "Bwipeout"}}
tools["nathom/filetype.nvim"] = {
	opt = false,
	config = conf.filetype,
}
tools['folke/todo-comments.nvim'] = {
    opt = true,
    requires = {{'nvim-lua/plenary.nvim', opt = true}},
    config = conf.todo,
}

tools['stevearc/aerial.nvim'] = {
    opt = true,
    after = "nvim-lspconfig",
    config = conf.aerial,
}

return tools
