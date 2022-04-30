local config = {}

function config.edge()
    vim.cmd [[set background=dark]]
    vim.g.edge_style = "aura"
    vim.g.edge_enable_italic = 1
    vim.g.edge_disable_italic_comment = 1
    vim.g.edge_show_eob = 1
    vim.g.edge_better_performance = 1
end

function config.catppuccin()
    require('catppuccin').setup({
        transparent_background = false,
        term_colors = true,
        styles = {
            comments = "italic",
            functions = "italic",
            keywords = "italic,bold",
            strings = "NONE",
            variables = "NONE"
        },
        integrations = {
            treesitter = true,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = "italic",
                    hints = "italic",
                    warnings = "italic",
                    information = "italic"
                },
                underlines = {
                    errors = "underline",
                    hints = "underline",
                    warnings = "underline",
                    information = "underline"
                }
            },
            lsp_trouble = true,
            lsp_saga = true,
            gitgutter = false,
            gitsigns = true,
            telescope = true,
            nvimtree = {enabled = true, show_root = true},
            which_key = true,
            indent_blankline = {enabled = true, colored_indent_levels = false},
            dashboard = true,
            neogit = false,
            vim_sneak = false,
            fern = false,
            barbar = false,
            bufferline = true,
            markdown = true,
            lightspeed = false,
            ts_rainbow = true,
            hop = true
        }
    })
end

function config.lualine()
    local gps = require("nvim-gps")
    local function gps_content()
        if gps.is_available() then
            return gps.get_location()
        else
            return ""
        end
    end

    local simple_sections = {
		lualine_a = { "mode" },
		lualine_b = { "filetype" },
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	}

    local symbols_outline = {
        sections = simple_sections,
        filetypes = {'Outline'}
    }

    local dapui_scopes = {
        sections = simple_sections,
		filetypes = { "dapui_scopes" },
	}

	local dapui_breakpoints = {
        sections = simple_sections,
		filetypes = { "dapui_breakpoints" },
	}

	local dapui_stacks = {
        sections = simple_sections,
		filetypes = { "dapui_stacks" },
	}

	local dapui_watches = {
        sections = simple_sections,
		filetypes = { "dapui_watches" },
	}


    require('lualine').setup {
        options = {
            icons_enabled = true,
            -- theme = 'onedark',
            -- theme = "catppuccin",
            -- theme = "kanagawa",
            theme = 'tokyonight',
            disabled_filetypes = {},
            component_separators = '|',
            section_separators = {left = '', right = ''}
        },

        sections = {
            lualine_a = {'mode'},
            lualine_b = {{'branch'}, {'diff'}},
            lualine_c = {
                {"lsp_progress"},
                {gps_content, cond = gps.is_available}
            },
            lualine_x = {
                {
                    'diagnostics',
                    sources = {'nvim_diagnostic'},
                    -- sources = {'nvim_lsp'},
                   -- color_error = "#BF616A",
                   -- color_warn = "#EBCB8B",
                   -- color_info = "#81A1AC",
                   -- color_hint = "#88C0D0",
                    symbols = {error = ' ', warn = ' ', info = ' '}
                },
            },
            lualine_y = {'filetype', 'encoding', 'fileformat'},
            lualine_z = {'progress', 'location'}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        extensions = {
            "quickfix", "nvim-tree", "toggleterm", "fugitive", symbols_outline, dapui_scopes,
			dapui_breakpoints,
			dapui_stacks,
			dapui_watches,
        }
    }
end

function config.nvim_bufferline()
    require('bufferline').setup {
        options = {
            --number = "both",
            -- numbers = function(opts)
            --     return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
            -- end,
            number = "none",
            modified_icon = '✥',
            buffer_close_icon = "",
            -- mappings = true,
            left_trunc_marker = "",
            right_trunc_marker = "",
            max_name_length = 14,
            max_prefix_length = 13,
            tab_size = 15,
            show_buffer_close_icons = false,
            show_buffer_icons = true,
            show_tab_indicators = false,
            separator_style = "slant",
            diagnostics = "nvim_lsp",
            always_show_bufferline = true,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
                    padding = 1
                }
            }
        }
    }
end

function config.nvim_tree()
    vim.g.nvim_tree_root_folder_modifier = ":e"
	vim.g.nvim_tree_icon_padding = " "
	vim.g.nvim_tree_symlink_arror = "  "
	vim.g.nvim_tree_respect_buf_cwd = 1

	vim.g.nvim_tree_icons = {
		["default"] = "", --
		["symlink"] = "",
		["git"] = {
			["unstaged"] = "",
			["staged"] = "", --
			["unmerged"] = "שׂ",
			["renamed"] = "", --
			["untracked"] = "ﲉ",
			["deleted"] = "",
			["ignored"] = "", --◌
		},
		["folder"] = {
			-- ['arrow_open'] = "",
			-- ['arrow_closed'] = "",
			["arrow_open"] = "",
			["arrow_closed"] = "",
			["default"] = "",
			["open"] = "",
			["empty"] = "",
			["empty_open"] = "",
			["symlink"] = "",
			["symlink_open"] = "",
		},
	}
    -- vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache', '.vscode'}
    local tree_cb = require'nvim-tree.config'.nvim_tree_callback
    require('nvim-tree').setup({
        git = {enable = true, ignore = false, timeout = 500},
        --ignore = {'.git', 'node_modules', '.cache', '.vscode'},
        --hide_dotfiles = true,
        auto_reload_on_write = true,
        open_on_tab = false,
        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = true,
        update_cwd = true,
        hijack_unnamed_buffer_when_opening = false,
        ignore_buffer_on_setup = false,
        sort_by = "name",
        --highlight_opened_files = true,
        --auto_ignore_ft = {'startify', 'dashboard'},
        update_focused_file = {
            enable = true,
            update_cwd = false,
            ignore_list = {}
        },
        hijack_directories = {
			enable = true,
			auto_open = true,
		},
        filters = {
            dotfiles = true,
            custom = { ".DS_Store" },
            exclude = {}
        },
        renderer = {
			indent_markers = {
				enable = true,
				icons = {
					corner = "└ ",
					edge = "│ ",
					none = "  ",
				},
			},
		},
        view = {
            width = 25,
            side = 'left',
            --auto_resize = false,
            hide_root_folder = false,
            preserve_window_proportions = false,
            number = false,
			relativenumber = false,
			signcolumn = "yes",
        },
        actions = {
			use_system_clipboard = true,
			change_dir = {
				enable = true,
				global = false,
			},
			open_file = {
				quit_on_open = false,
				resize_window = false,
				window_picker = {
					enable = true,
					chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
					exclude = {
						filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
						buftype = { "nofile", "terminal", "help" },
					},
				},
			},
		},
        ignore_ft_on_setup = {},
    })
end

function config.gitsigns()
    if not packer_plugins['plenary.nvim'].loaded then
        vim.cmd [[packadd plenary.nvim]]
    end
    require('gitsigns').setup {
        signs = {
           -- add = {hl = 'GitGutterAdd', text = '▋'},
           -- change = {hl = 'GitGutterChange', text = '▋'},
           -- delete = {hl = 'GitGutterDelete', text = '▋'},
           -- topdelete = {hl = 'GitGutterDeleteChange', text = '▔'},
           -- changedelete = {hl = 'GitGutterChange', text = '▎'}
            add = {
                hl = 'GitSignsAdd',
                text = '│',
                numhl = 'GitSignsAddNr',
                linehl = 'GitSignsAddLn'
            },
            change = {
                hl = 'GitSignsChange',
                text = '│',
                numhl = 'GitSignsChangeNr',
                linehl = 'GitSignsChangeLn'
            },
            delete = {
                hl = 'GitSignsDelete',
                text = '_',
                numhl = 'GitSignsDeleteNr',
                linehl = 'GitSignsDeleteLn'
            },
            topdelete = {
                hl = 'GitSignsDelete',
                text = '‾',
                numhl = 'GitSignsDeleteNr',
                linehl = 'GitSignsDeleteLn'
            },
            changedelete = {
                hl = 'GitSignsChange',
                text = '~',
                numhl = 'GitSignsChangeNr',
                linehl = 'GitSignsChangeLn'
            }
        },
        keymaps = {
            -- Default keymap options
            noremap = true,
            buffer = true,

            ['n ]g'] = {
                expr = true,
                "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"
            },
            ['n [g'] = {
                expr = true,
                "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"
            },

            ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
            ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
            ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
            ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
            ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
            ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
            ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
            ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

            -- Text objects
            ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
            ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
        },
        watch_gitdir = {interval = 1000, follow_files = true},
        current_line_blame = true,
        current_line_blame_opts = {delay = 1000, virtual_text_pos = 'eol'},
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        word_diff = false,
        --use_internal_diff = true -- If luajit is present
        diff_opts = {internal = true}
    }
end

function config.indent_blankline()
    vim.opt.termguicolors = true
    vim.opt.list = true
    -- vim.opt.listchars:append("space:⋅")
    require("indent_blankline").setup {
        char = "│",
        show_first_indent_level = true,
        filetype_exclude = {
            "startify", "dashboard", "dotooagenda", "log", "fugitive",
            "gitcommit", "packer", "vimwiki", "markdown", "json", "txt",
            "vista", "help", "todoist", "NvimTree", "peekaboo", "git",
            "TelescopePrompt", "undotree", "flutterToolsOutline", "" -- for all buffers without a file type
        },
        buftype_exclude = {"terminal", "nofile"},
        show_trailing_blankline_indent = false,
        show_current_context = true,
        space_char_blankline = " ",
        context_patterns = {
            "class", "function", "method", "block", "list_literal", "selector",
            "^if", "^table", "if_statement", "while", "for", "type", "var",
            "import"
        },
        space_char_blankline = " "
    }
    -- because lazy load indent-blankline so need readd this autocmd
    vim.cmd('autocmd CursorMoved * IndentBlanklineRefresh')
end

--function config.zen_mode() require('zen-mode').setup {} end
--
--function config.twilight() require('twilight').setup {} end

function config.kanagawa()
    require('kanagawa').setup({
        undercurl = true, -- enable undercurls
        commentStyle = "italic",
        functionStyle = "bold,italic",
        keywordStyle = "italic",
        statementStyle = "bold",
        typeStyle = "NONE",
        variablebuiltinStyle = "italic",
        specialReturn = true, -- special highlight for the return keyword
        specialException = true, -- special highlight for exception handling keywords 
        transparent = false, -- do not set background color
        dimInactive = true, -- dim inactive window `:h hl-NormalNC`
        colors = {},
        overrides = {}
    })
end

function config.tokyonight()
    vim.g.tokyonight_style = "storm"
    vim.g.tokyonight_italic_functions = true
    vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
end

return config
