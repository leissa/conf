local icons = require 'icons'

return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'folke/neodev.nvim',
            {
                "ray-x/lsp_signature.nvim",
                enabled = false,
                event = "VeryLazy",
                opts = {},
                config = function(_, opts)
                    local sig = require 'lsp_signature'
                    sig.setup(opts)
                    sig.on_attach()
                end
            },
            {
                "p00f/clangd_extensions.nvim",
                lazy = true,
                config = function() end,
                opts = {
                    inlay_hints = {
                        inline = false,
                    },
                    ast = {
                        --These require codicons (https://github.com/microsoft/vscode-codicons)
                        role_icons = {
                            type = "",
                            declaration = "",
                            expression = "",
                            specifier = "",
                            statement = "",
                            ["template argument"] = "",
                        },
                        kind_icons = {
                            Compound = "",
                            Recovery = "",
                            TranslationUnit = "",
                            PackExpansion = "",
                            TemplateTypeParm = "",
                            TemplateTemplateParm = "",
                            TemplateParamObject = "",
                        },
                    },
                },
                keys = {
                    { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
                },
            },
        },
        config = function()
            require("neodev").setup {} -- IMPORTANT: make sure to setup neodev BEFORE lspconfig

            local lsp  = require 'lspconfig'
            local caps = require('cmp_nvim_lsp').default_capabilities()
            lsp.asm_lsp.setup { capabilities = caps }
            lsp.bashls.setup { capabilities = caps }
            lsp.pyright.setup { capabilities = caps }
            lsp.tsserver.setup { capabilities = caps }

            lsp.clangd.setup {
                capabilities = caps,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                },
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                },
            }

            lsp.java_language_server.setup {
                capabilities = caps,
                cmd          = { "/usr/share/java/java-language-server/lang_server_linux.sh" },
            }

            lsp.rust_analyzer.setup {
                capabilities = caps,
                settings = {
                    ['rust-analyzer'] = {},
                },
            }

            lsp.lua_ls.setup {
                capabilities = caps,
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace"
                        }
                    }
                }
            }

            vim.g['tex_flavor'] = 'latex'
            lsp.texlab.setup {
                cmd = { "texlab" },
                filetypes = { "tex", "bib" },
                settings = {
                    texlab = {
                        rootDirectory = nil,
                        --      ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓
                        build = _G.TeXMagicBuildConfig,
                        --      ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
                        forwardSearch = {
                            executable = "okular",
                            args = { "%p" }
                        }
                    }
                }
            }

            vim.diagnostic.config({
                virtual_text  = false,
                severity_sort = false,
                signs         = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
                        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
                        [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
                    },
                },
                float         = {
                    border = 'rounded',
                    source = true,
                }
            })

            -- Show line diagnostics automatically in hover window
            -- vim.o.updatetime = 250
            -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

            local keymaps = {
                { "<leader>cl", "<cmd>LspInfo<cr>",                                                                     desc = "Lsp Info" },
                { "gd",         function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end,      desc = "Goto Definition",            has = "definition" },
                { "gr",         "<cmd>Telescope lsp_references<cr>",                                                    desc = "References" },
                { "gD",         vim.lsp.buf.declaration,                                                                desc = "Goto Declaration" },
                { "gI",         function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end,  desc = "Goto Implementation" },
                { "gy",         function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
                { "K",          vim.lsp.buf.hover,                                                                      desc = "Hover" },
                { "gK",         vim.lsp.buf.signature_help,                                                             desc = "Signature Help",             has = "signatureHelp" },
                { "<c-k>",      vim.lsp.buf.signature_help,                                                             mode = "i",                          desc = "Signature Help", has = "signatureHelp" },
                { "<leader>ca", vim.lsp.buf.code_action,                                                                desc = "Code Action",                mode = { "n", "v" },     has = "codeAction" },
                { "<leader>cc", vim.lsp.codelens.run,                                                                   desc = "Run Codelens",               mode = { "n", "v" },     has = "codeLens" },
                { "<leader>cf", function() vim.lsp.buf.format { async = true } end,                                     desc = "code: format" },
                { "<leader>cr", vim.lsp.buf.rename,                                                                     desc = "Rename",                     mode = { "n" } },
                { "<leader>cR", vim.lsp.buf.references,                                                                 desc = "References"},
                { "<leader>cC", vim.lsp.codelens.refresh,                                                               desc = "Refresh & Display Codelens", mode = { "n" },          has = "codeLens" },
                {
                    "<leader>cA",
                    function()
                        vim.lsp.buf.code_action({
                            context = {
                                only = { "source", },
                                diagnostics = {},
                            },
                        })
                    end,
                    desc = "Source Action",
                    has = "codeAction",
                }
            }

            -- Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                desc     = 'LSP actions',
                group    = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc' -- Enable completion triggered by <c-x><c-o>
                    for _, k in pairs(keymaps) do
                        vim.keymap.set(k.mode or "n", k[1], k[2], { desc = k.desc or "" })
                    end
                end
            })
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
        },
        config = function()
            local cmp = require 'cmp'
            cmp.setup({
                snippet = {
                    expand = function(args)                  -- REQUIRED - you must specify a snippet engine
                        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>']     = cmp.mapping.scroll_docs(-4),
                    ['<C-f>']     = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>']     = cmp.mapping.abort(),
                    ['<CR>']      = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' }, -- For vsnip users.
                    -- { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                    { name = 'buffer' },
                    { name = 'path' },
                }),
                formatting = {
                    format = function(_, item)
                        if icons.kinds[item.kind] then
                            item.kind = icons.kinds[item.kind] .. item.kind
                        end
                        return item
                    end,
                    -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                    -- ellipsis_char = icons.misc.dots, -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    -- show_labelDetails = true,        -- show labelDetails in menu. Disabled by default
                },
                view = {
                    docs = {
                        auto_open = true
                    }
                },
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                    { name = 'buffer' },
                })
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                    { name = 'cmdline' }
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })
        end,
    },
}
