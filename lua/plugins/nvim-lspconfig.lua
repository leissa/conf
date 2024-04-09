return {
    'neovim/nvim-lspconfig',
    dependencies = { 'folke/neodev.nvim' },
    config = function()
        require("neodev").setup {} -- IMPORTANT: make sure to setup neodev BEFORE lspconfig

        local lspconfig = require 'lspconfig'
        lspconfig.asm_lsp.setup {}
        lspconfig.bashls.setup {}
        lspconfig.clangd.setup {}
        lspconfig.pyright.setup {}
        lspconfig.tsserver.setup {}

        lspconfig.java_language_server.setup {
            cmd = { "/usr/share/java/java-language-server/lang_server_linux.sh" },
        }

        lspconfig.rust_analyzer.setup {
            settings = {
                ['rust-analyzer'] = {},
            },
        }

        lspconfig.lua_ls.setup {
            -- on_init = function(client)
            --     local path = client.workspace_folders[1].name
            --     if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
            --         return
            --     end
            --
            --     client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            --         runtime = {
            --             -- Tell the language server which version of Lua you're using
            --             -- (most likely LuaJIT in the case of Neovim)
            --             version = 'LuaJIT'
            --         },
            --         -- Make the server aware of Neovim runtime files
            --         workspace = {
            --             checkThirdParty = false,
            --             library = {
            --             vim.env.VIMRUNTIME
            --             -- Depending on the usage, you might want to add additional paths here.
            --             -- "${3rd}/luv/library"
            --             -- "${3rd}/busted/library",
            --             }
            --             -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            --             -- library = vim.api.nvim_get_runtime_file("", true)
            --         }
            --     })
            -- end,
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace"
                    }
                }
            }
        }

        vim.diagnostic.config({
            virtual_text = false
        })

        -- Show line diagnostics automatically in hover window
        -- vim.o.updatetime = 250
        -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

        -- Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc' -- Enable completion triggered by <c-x><c-o>
            end,
        })
    end,
    keys = {
        --help
        {'K', vim.lsp.buf.hover, desc = "help" },
        {'<leader>lk', vim.lsp.buf.signature_help, desc = "signature help" },
        -- navigate
        { 'gd',     vim.lsp.buf.definition,      desc = "Goto: definition" },
        { 'gD',     vim.lsp.buf.declaration,     desc = "Goto: declaration" },
        { 'g<c-d>', vim.lsp.buf.type_definition, desc = "Goto: type definition" },
        { 'gi',     vim.lsp.buf.implementation,  desc = "Goto: implementation" },
        -- diagnostics
        { '<leader>ds', vim.diagnostic.open_float, desc = 'Diagnostics: show' },
        { '<leader>dn', vim.diagnostic.goto_next,  desc = 'Diagnostics: next' },
        { '<leader>dp', vim.diagnostic.goto_prev,  desc = 'Diagnostics: prev' },
        -- workspace folders
        {'<leader>wa', vim.lsp.buf.add_workspace_folder,    desc = "workspace: add folder" },
        {'<leader>wr', vim.lsp.buf.remove_workspace_folder, desc = "workspace: remove folder" },
        {'<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "workspace: list folders" },
        -- code
        {'<leader>ca', vim.lsp.buf.code_action, mode = { 'n', 'v' },       desc = "code: action" },
        {'<leader>cf', function() vim.lsp.buf.format { async = true } end, desc = "code: format" },
        {'<leader>cl', vim.lsp.buf.references,                             desc = "code: list all references of symbol" },
        {'<leader>cr', vim.lsp.buf.rename,                                 desc = "code: rename" },
    },
}
