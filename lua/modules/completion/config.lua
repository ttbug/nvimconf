local config = {}

function config.nvim_lsp() require('modules.completion.lspconfig') end

-- function config.saga()
--     vim.api.nvim_command("autocmd CursorHold * Lspsaga show_line_diagnostics")
-- end

function config.cmp()
    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end
    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and
                   vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(
                       col, col):match("%s") == nil
    end

    local cmp = require('cmp')
    cmp.setup ({
        formatting = {
            format = function(entry, vim_item)
                local lspkind_icons = {
                    Text = "",
                    Method = "",
                    Function = "",
                    Constructor = "",
                    Field = "ﰠ",
                    Variable = "",
                    Class = "ﴯ",
                    Interface = "",
                    Module = "",
                    Property = "ﰠ",
                    Unit = "塞",
                    Value = "",
                    Enum = "",
                    Keyword = "",
                    Snippet = "",
                    Color = "",
                    File = "",
                    Reference = "",
                    Folder = "",
                    EnumMember = "",
                    Constant = "",
                    Struct = "פּ",
                    Event = "",
                    Operator = "",
                    TypeParameter = ""
                }
                -- load lspkind icons
                vim_item.kind = string.format("%s %s",
                                              lspkind_icons[vim_item.kind],
                                              vim_item.kind)

                vim_item.menu = ({
                    -- cmp_tabnine = "[TN]",
                    orgmode = "[ORG]",
                    nvim_lsp = "[LSP]",
                    nvim_lua = "[LUA]",
                    buffer = "[BUF]",
                    path = "[PATH]",
                    tmux = "[TMUX]",
                    luasnip = "[SNIP]",
                    spell = "[SPELL]"
                })[entry.source.name]

                return vim_item
            end
        },
        -- You can set mappings if you want
        mapping = {
            ['<CR>'] = cmp.mapping.confirm({select = true}),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-e>'] = cmp.mapping.close(),
            -- ["<Tab>"] = function(fallback)
            --     if vim.fn.pumvisible() == 1 then
            --         vim.fn.feedkeys(t("<C-n>"), "n")
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            -- end,
            -- ["<S-Tab>"] = function(fallback)
            --     if vim.fn.pumvisible() == 1 then
            --         vim.fn.feedkeys(t("<C-p>"), "n")
            end, {"i", "s"}),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, {"i", "s"}),
            ["<C-h>"] = function(fallback)
                if require("luasnip").jumpable(-1) then
                    vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
                else
                    fallback()
                end
            end,
            ["<C-l>"] = function(fallback)
                if require("luasnip").expand_or_jumpable() then
                    vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
                else
                    fallback()
                end
            end
        },

        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end
        },

        -- You should specify your *installed* sources.
        sources = {
            {name = 'nvim_lsp'}, {name = 'nvim_lua'}, {name = 'luasnip'},
            {name = 'buffer'}, {name = 'path'}, {name = 'spell'},
            {name = 'tmux'}, {name = "orgmode"}
            -- {name = 'cmp_tabnine'},
        }
    })

    
--    cmp.setup.cmdline("/", {
--        mapping = cmp.mapping.preset.cmdline(),
--        sources = { { name = "buffer" } }
--    })
--    cmp.setup.cmdline("?", {
--        mapping = cmp.mapping.preset.cmdline(),
--        sources = { { name = "buffer" } }
--    })
--    cmp.setup.cmdline(":", {
--        mapping = cmp.mapping.preset.cmdline(),
--        sources = cmp.config.sources(
--            { { name = "path" } },
--            { { name = "cmdline" } }
--        )
--    })
end

function config.luasnip()
    require('luasnip').config.set_config {
        history = true,
        updateevents = "TextChanged,TextChangedI"
    }
    require("luasnip/loaders/from_vscode").load()
end

-- function config.tabnine()
--     local tabnine = require('cmp_tabnine.config')
--     tabnine:setup({max_line = 1000, max_num_results = 20, sort = true})
-- end

function config.autopairs()
    require('nvim-autopairs').setup {}
    -- require("nvim-autopairs.completion.cmp").setup({
    --     map_cr = true,
    --     map_complete = true,
    --     auto_select = true
    -- })
    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on('confirm_done',
                    cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))
    cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"
end

--function config.nvim_lsputils()
--    if vim.fn.has('nvim-0.5.1') == 1 then
--        vim.lsp.handlers['textDocument/codeAction'] =
--            require'lsputil.codeAction'.code_action_handler
--        vim.lsp.handlers['textDocument/references'] =
--            require'lsputil.locations'.references_handler
--        vim.lsp.handlers['textDocument/definition'] =
--            require'lsputil.locations'.definition_handler
--        vim.lsp.handlers['textDocument/declaration'] =
--            require'lsputil.locations'.declaration_handler
--        vim.lsp.handlers['textDocument/typeDefinition'] =
--            require'lsputil.locations'.typeDefinition_handler
--        vim.lsp.handlers['textDocument/implementation'] =
--            require'lsputil.locations'.implementation_handler
--        vim.lsp.handlers['textDocument/documentSymbol'] =
--            require'lsputil.symbols'.document_handler
--        vim.lsp.handlers['workspace/symbol'] =
--            require'lsputil.symbols'.workspace_handler
--    else
--        local bufnr = vim.api.nvim_buf_get_number(0)
--
--        vim.lsp.handlers['textDocument/codeAction'] =
--            function(_, _, actions)
--                require('lsputil.codeAction').code_action_handler(nil, actions,
--                                                                  nil, nil, nil)
--            end
--
--        vim.lsp.handlers['textDocument/references'] =
--            function(_, _, result)
--                require('lsputil.locations').references_handler(nil, result, {
--                    bufnr = bufnr
--                }, nil)
--            end
--
--        vim.lsp.handlers['textDocument/definition'] =
--            function(_, method, result)
--                require('lsputil.locations').definition_handler(nil, result, {
--                    bufnr = bufnr,
--                    method = method
--                }, nil)
--            end
--
--        vim.lsp.handlers['textDocument/declaration'] = function(_, method,
--                                                                result)
--            require('lsputil.locations').declaration_handler(nil, result, {
--                bufnr = bufnr,
--                method = method
--            }, nil)
--        end
--
--        vim.lsp.handlers['textDocument/typeDefinition'] = function(_, method,
--                                                                   result)
--            require('lsputil.locations').typeDefinition_handler(nil, result, {
--                bufnr = bufnr,
--                method = method
--            }, nil)
--        end
--
--        vim.lsp.handlers['textDocument/implementation'] = function(_, method,
--                                                                   result)
--            require('lsputil.locations').implementation_handler(nil, result, {
--                bufnr = bufnr,
--                method = method
--            }, nil)
--        end
--
--        vim.lsp.handlers['textDocument/documentSymbol'] =
--            function(_, _, result, _, bufn)
--                require('lsputil.symbols').document_handler(nil, result,
--                                                            {bufnr = bufn}, nil)
--            end
--
--        vim.lsp.handlers['textDocument/symbol'] =
--            function(_, _, result, _, bufn)
--                require('lsputil.symbols').workspace_handler(nil, result,
--                                                             {bufnr = bufn}, nil)
--            end
--    end
--end

function config.bqf()
	vim.cmd([[
    hi BqfPreviewBorder guifg=#F2CDCD ctermfg=71
    hi link BqfPreviewRange Search
]])

	require("bqf").setup({
		auto_enable = true,
		auto_resize_height = true, -- highly recommended enable
		preview = {
			win_height = 12,
			win_vheight = 12,
			delay_syntax = 80,
			border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
			should_preview_cb = function(bufnr, qwinid)
				local ret = true
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				local fsize = vim.fn.getfsize(bufname)
				if fsize > 100 * 1024 then
					-- skip file size greater than 100k
					ret = false
				elseif bufname:match("^fugitive://") then
					-- skip fugitive buffer
					ret = false
				end
				return ret
			end,
		},
		-- make `drop` and `tab drop` to become preferred
		func_map = {
			drop = "o",
			openc = "O",
			split = "<C-s>",
			tabdrop = "<C-t>",
			tabc = "",
			ptogglemode = "z,",
		},
		filter = {
			fzf = {
				action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
				extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
			},
		},
	})
end


return config
