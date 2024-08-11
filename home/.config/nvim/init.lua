vim.cmd [[set nocp tgc title confirm nosmd ls=3 nu rnu so=999 nocul]]
vim.cmd [[set ts=4 sw=4 et sta si cc=100 tw=100 sm hls is]]
vim.cmd [[inoremap # X#]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup {
                transparent_background = true
            }
            vim.cmd.colorscheme "catppuccin"
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {
                tab = {
                    sync = {
                        open = true,
                        close = true,
                    },
                },
            }
        end,
    },
    {
        'ojroques/nvim-hardline',
        config = function()
            require("hardline").setup {}
        end,
    },
    {
        "neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
        lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
        dependencies = {
            -- main one
            { "ms-jpq/coq_nvim", branch = "coq" },

            -- 9000+ Snippets
            { "ms-jpq/coq.artifacts", branch = "artifacts" },

            -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
            -- Need to **configure separately**
            { 'ms-jpq/coq.thirdparty', branch = "3p" },
            -- - shell repl
            -- - nvim lua api
            -- - scientific calculator
            -- - comment banner
            -- - etc
        },
        init = function()
            vim.g.coq_settings = {
                auto_start = 'shut-up', -- if you want to start COQ at startup
                -- Your COQ settings here
            }
        end,
        config = function()
            -- Your LSP settings here
            local lsp = require("lspconfig")

            vim.api.nvim_create_autocmd('LspNotify', {
                callback = function(args)
                    local bufnr = args.buf
                    local client_id = args.data.client_id
                    local method = args.data.method
                    local params = args.data.params
                    -- do something with the notification
                    if method == 'textDocument/...' then
                        update_buffer(bufnr)
                    end
                end,
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    local opts = { buffer = args.buf, noremap = true, silent = true }

                    if client.supports_method('textDocument/completion') then
                        -- Enable auto-completion
                        -- vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
                    end

                    if client.supports_method('textDocument/formatting') then
                        -- Format the current buffer on save
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({bufnr = args.buf, id = client.id})
                            end,
                        })
                    end

                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)

                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

                    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
                    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
                    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
                    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

                    vim.lsp.inlay_hint.enable(true, {
                        bufnr = args.buf,
                    })
                end,
            })

            vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
                group = vim.api.nvim_create_augroup("code_action_sign", { clear = true }),
                callback = function()
                    local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
                    local params = vim.lsp.util.make_range_params()
                    params.context = context
                    vim.lsp.buf_request(0, 'textDocument/codeAction', params,
                        function(err, result, ctx, config)
                            -- do something with result
                            -- e.g. check if empty and show some indication such as a sign
                        end
                    )
                end,
            })

            lsp.clangd.setup {}
        end,
    },
    {
        'mrcjkb/rustaceanvim',
        lazy = false, -- This plugin is already lazy

        init = function()
            vim.g.rustaceanvim = {
                -- Plugin configuration
                tools = {
                },

                -- LSP configuration
                server = {
                    cmd = {
                        "/usr/bin/env",
                        "CARGO_HOME=/home/yuki/.local/share/cargo",
                        "RUSTUP_HOME=/home/yuki/.local/share/rustup",
                        "/usr/bin/rustup",
                        "run",
                        "nightly",
                        "rust-analyzer",
                    },

                    on_attach = function(client, bufnr)
                        local opts = { buffer = bufnr, noremap = true, silent = true }

                        vim.keymap.set('n', '<space>a', function()
                            vim.cmd.RustLsp('codeAction')
                        end, opts)

                        vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
                            group = vim.api.nvim_create_augroup("code_action_sign", {
                                clear = true
                            }),
                            callback = function()
                                vim.cmd.RustLsp { 'hover', 'actions' }
                            end,
                        })
                    end,

                    default_settings = {
                        ['rust-analyzer'] = {
                            inlayHints = {
                                lifetimeElisionHints = {
                                    enable = true,
                                    useParameterNames = true,
                                },
                            },
                            checkOnSave = true,
                            check = {
                                enable = true,
                                command = 'clippy',
                                features = 'all',
                            },
                            procMacro = {
                                enable = true,
                            },
                        },
                    },
                },

                -- DAP configuration
                dap = {
                },
            }
        end,
        -- vim.cmd.RustLsp({ 'renderDiagnostic', 'cycle' })
    },
    {
        'xiyaowong/virtcolumn.nvim',
        init = function()
            vim.g.virtcolumn_char = '|'
            vim.g.virtcolumn_priority = 10
        end,
    },
}, {
    git = {
        timeout = 3600, -- kill after AN HOUR instead of 2 minutes
    }
})
