--if not packer_plugins['nvim-lspconfig'].loaded then
--    vim.cmd [[packadd nvim-lspconfig]]
--end

if not packer_plugins['lspsaga.nvim'].loaded then
    vim.cmd [[packadd lspsaga.nvim]]
end

if not packer_plugins['nvim-lsp-installer'].loaded then
    vim.cmd [[packadd nvim-lsp-installer]]
end

if not packer_plugins['lsp_signature.nvim'].loaded then
    vim.cmd [[packadd lsp_signature.nvim]]
end

local nvim_lsp = require('lspconfig')
-- local lsp_install = require('lspinstall')
local lsp_installer = require('nvim-lsp-installer')

lsp_installer.settings {
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}
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

local function custom_attach()
    require('lsp_signature').on_attach({
        bind = true,
        use_lspsaga = false,
        floating_window = true,
        fix_pos = true,
        hint_enable = true,
        hi_parameter = "Search",
        handler_opts = {"double"}
    })
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

lsp_installer.on_server_ready(function(server)
    local opts = {}

    if (server.name == "sumneko_lua") then
        opts.settings = {
            Lua = {
                diagnostics = {globals = {"vim", "packer_plugins"}},
                workspace = {
                    library = {
                        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                        [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true
                    },
                    maxPreload = 100000,
                    preloadFileSize = 10000
                },
                telemetry = {enable = false}
            }
        }
    elseif (server.name == "clangd") then
        opts.commands = {
            ClangdSwitchSourceHeader = {
                function()
                    switch_source_header_splitcmd(0, "edit")
                end,
                description = "Open source/header in current buffer"
            },
            ClangdSwitchSourceHeaderVSplit = {
                function()
                    switch_source_header_splitcmd(0, "vsplit")
                end,
                description = "Open source/header in a new vsplit"
            },
            ClangdSwitchSourceHeaderSplit = {
                function()
                    switch_source_header_splitcmd(0, "split")
                end,
                description = "Open source/header in a new split"
            }
        }
    end
    opts.capabilities = capabilities
    opts.flags = {debounce_text_changes = 500}
    opts.on_attach = custom_attach

    server:setup(opts)
end)
