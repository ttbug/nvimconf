--if not packer_plugins['nvim-lspconfig'].loaded then
--    vim.cmd [[packadd nvim-lspconfig]]
--end

vim.cmd [[packadd lspsaga.nvim]]
vim.cmd [[packadd nvim-lsp-installer]]
vim.cmd [[packadd lsp_signature.nvim]]
vim.cmd([[packadd vim-illuminate]])

local nvim_lsp = require('lspconfig')
-- local lsp_install = require('lspinstall')
local saga = require("lspsaga")
local lsp_installer = require('nvim-lsp-installer')

saga.init_lsp_saga {
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = ''
}

lsp_installer.settings {
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

lsp_installer.setup({})
-- local saga = require('lspsaga')
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- saga.init_lsp_saga({code_action_icon = '💡'})

capabilities.textDocument.completion.completionItem.documentationFormat = {
    'markdown', 'plaintext'
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport =
    true
capabilities.textDocument.completion.completionItem.tagSupport = {
    valueSet = {1}
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {'documentation', 'detail', 'additionalTextEdits'}
}

-- local function setup_servers()
--     lsp_install.setup()
--     local servers = lsp_install.installed_servers()
--     for _, lsp in pairs(servers) do
--         if lsp == "lua" then
--             nvim_lsp[lsp].setup {
--                 capabilities = capabilities,
--                 flags = {debounce_text_changes = 500},
--                 settings = {
--                     Lua = {
--                         diagnostics = {globals = {"vim", "packer_plugins"}},
--                         workspace = {
--                             library = {
--                                 [vim.fn.expand "$VIMRUNTIME/lua"] = true,
--                                 [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true
--                             },
--                             maxPreload = 100000,
--                             preloadFileSize = 10000
--                         },
--                         telemetry = {enable = false}
--                     }
--                 },
--                 on_attach = function()
--                     require('lsp_signature').on_attach({
--                         bind = true,
--                         use_lspsaga = false,
--                         floating_window = true,
--                         fix_pos = true,
--                         hint_enable = true,
--                         hi_parameter = "Search",
--                         handler_opts = {"double"},
--                         zindex = 50,
--                         transpancy = 20
--                     })
--                 end
--             }
--         else
--             nvim_lsp[lsp].setup {
--                 capabilities = capabilities,
--                 flags = {debounce_text_changes = 500},
--                 on_attach = function()
--                     require('lsp_signature').on_attach({
--                         bind = true,
--                         use_lspsaga = false,
--                         floating_window = true,
--                         fix_pos = true,
--                         hint_enable = true,
--                         hi_parameter = "Search",
--                         handler_opts = {"double"}
--                     })
--                 end
--             }
--         end
--     end
-- end

-- lsp_install.post_install_hook = function()
--     setup_servers() -- reload installed servers
--     vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
-- end

-- setup_servers()

local function custom_attach(client)
    require('lsp_signature').on_attach({
        bind = true,
        use_lspsaga = false,
        floating_window = true,
        fix_pos = true,
        hint_enable = true,
        hi_parameter = "Search",
        handler_opts = {"double"}
    })

    require("illuminate").on_attach(client)
end

local function switch_source_header_splitcmd(bufnr, splitcmd)
    bufnr = nvim_lsp.util.validate_bufnr(bufnr)
    local params = {uri = vim.uri_from_bufnr(bufnr)}
    vim.lsp.buf_request(bufnr, 'textDocument/switchSourceHeader', params,
                        function(err, result)
        if err then error(tostring(err)) end
        if not result then
            print("Corresponding file can’t be determined")
            return
        end
        vim.api.nvim_command(splitcmd .. ' ' .. vim.uri_to_fname(result))
    end)
end

-- Override server settings here


for _, server in ipairs(lsp_installer.get_installed_servers()) do
	if server.name == "gopls" then
		nvim_lsp.gopls.setup({
			on_attach = custom_attach,
			flags = { debounce_text_changes = 500 },
			capabilities = capabilities,
            cmd = { "gopls", "-remote=auto" },
			settings = {
				gopls = {
					usePlaceholders = true,
					analyses = {
						nilness = true,
						shadow = true,
						unusedparams = true,
						unusewrites = true,
					},
				},
			},
		})
    elseif server.name == "sumneko_lua" then
		nvim_lsp.sumneko_lua.setup({
			capabilities = capabilities,
			on_attach = function(client)
				client.resolved_capabilities.document_formatting = false
				custom_attach(client)
			end,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
						},
						maxPreload = 100000,
						preloadFileSize = 10000,
					},
					telemetry = { enable = false },
				},
			},
		})
	elseif server.name == "clangd" then
        local copy_capabilities = capabilities
		copy_capabilities.offsetEncoding = { "utf-16" }
		nvim_lsp.clangd.setup({
			capabilities = copy_capabilities,
			single_file_support = true,
			on_attach = function(client)
				client.resolved_capabilities.document_formatting = false
				custom_attach(client)
			end,
			args = {
				"--background-index",
				"-std=c++20",
				"--pch-storage=memory",
				"--clang-tidy",
				"--suggest-missing-includes",
			},
			commands = {
				ClangdSwitchSourceHeader = {
					function()
						switch_source_header_splitcmd(0, "edit")
					end,
					description = "Open source/header in current buffer",
				},
				ClangdSwitchSourceHeaderVSplit = {
					function()
						switch_source_header_splitcmd(0, "vsplit")
					end,
					description = "Open source/header in a new vsplit",
				},
				ClangdSwitchSourceHeaderSplit = {
					function()
						switch_source_header_splitcmd(0, "split")
					end,
					description = "Open source/header in a new split",
				},
			},
		})
	elseif server.name == "jsonls" then
        nvim_lsp.jsonls.setup({
			flags = { debounce_text_changes = 500 },
			capabilities = capabilities,
			on_attach = custom_attach,
			settings = {
				json = {
					-- Schemas https://www.schemastore.org
					schemas = {
						{
							fileMatch = { "package.json" },
							url = "https://json.schemastore.org/package.json",
						},
						{
							fileMatch = { "tsconfig*.json" },
							url = "https://json.schemastore.org/tsconfig.json",
						},
						{
							fileMatch = {
								".prettierrc",
								".prettierrc.json",
								"prettier.config.json",
							},
							url = "https://json.schemastore.org/prettierrc.json",
						},
						{
							fileMatch = { ".eslintrc", ".eslintrc.json" },
							url = "https://json.schemastore.org/eslintrc.json",
						},
						{
							fileMatch = {
								".babelrc",
								".babelrc.json",
								"babel.config.json",
							},
							url = "https://json.schemastore.org/babelrc.json",
						},
						{
							fileMatch = { "lerna.json" },
							url = "https://json.schemastore.org/lerna.json",
						},
						{
							fileMatch = {
								".stylelintrc",
								".stylelintrc.json",
								"stylelint.config.json",
							},
							url = "http://json.schemastore.org/stylelintrc.json",
						},
						{
							fileMatch = { "/.github/workflows/*" },
							url = "https://json.schemastore.org/github-workflow.json",
						},
					},
				},
			},
		})
	else
		nvim_lsp[server.name].setup({
			capabilities = capabilities,
			on_attach = function(client)
				client.server_capabilities.document_formatting = false
				custom_attach(client)
			end,
		})
	end
end



--lsp_installer.on_server_ready(function(server)
--    local opts = {}
--
--    if (server.name == "sumneko_lua") then
--        opts.settings = {
--            Lua = {
--                diagnostics = {globals = {"vim", "packer_plugins"}},
--                workspace = {
--                    library = {
--                        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
--                        [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true
--                    },
--                    maxPreload = 100000,
--                    preloadFileSize = 10000
--                },
--                telemetry = {enable = false}
--            }
--        }
--    elseif (server.name == "clangd") then
--        opts.commands = {
--            ClangdSwitchSourceHeader = {
--                function()
--                    switch_source_header_splitcmd(0, "edit")
--                end,
--                description = "Open source/header in current buffer"
--            },
--            ClangdSwitchSourceHeaderVSplit = {
--                function()
--                    switch_source_header_splitcmd(0, "vsplit")
--                end,
--                description = "Open source/header in a new vsplit"
--            },
--            ClangdSwitchSourceHeaderSplit = {
--                function()
--                    switch_source_header_splitcmd(0, "split")
--                end,
--                description = "Open source/header in a new split"
--            }
--        }
--    end
--    opts.capabilities = capabilities
--    opts.flags = {debounce_text_changes = 500}
--    opts.on_attach = custom_attach
--
--    server:setup(opts)
--end)
