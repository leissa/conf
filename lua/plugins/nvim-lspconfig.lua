return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {'folke/neodev.nvim'},
        config = function()
            require("neodev").setup({ -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
                -- add any options here, or leave empty to use the default settings
            })

            local lspconfig = require'lspconfig'
            lspconfig.bashls.  setup{}
            lspconfig.clangd.  setup{}
            lspconfig.pyright. setup{}
            lspconfig.tsserver.setup{}

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

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc' -- Enable completion triggered by <c-x><c-o>

                    -- Buffer local mappings. See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    -- navigate
                    vim.keymap.set('n', 'gD',        vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd',        vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'gi',        vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<space>D',  vim.lsp.buf.type_definition, opts)
                    --help
                    vim.keymap.set('n', 'K',         vim.lsp.buf.hover, opts)
                    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    -- workspace folders
                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
                    -- code
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set('n', 'gr',        vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<space>f',  function() vim.lsp.buf.format { async = true } end, opts)
                    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                end,
            })
        end,
        keys = {
            -- diagnostics
            { '<space>e', vim.diagnostic.open_float, desc = 'Diagnostics: open float' },
            { '[d',       vim.diagnostic.goto_prev,  desc = 'Diagnostics: goto prev' },
            { ']d',       vim.diagnostic.goto_next,  desc = 'Diagnostics: goto next' },
            { '<space>q', vim.diagnostic.setloclist, desc = 'Diagnostics: set location list' },
        },
    },
}
