return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        -- import lspconfig plugin
        local lspconfig = require("lspconfig")

        -- import cmp-nvim-lsp plugin
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap -- for conciseness

        local opts = { noremap = true, silent = true }
        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            -- set keybinds
            opts.desc = "Show LSP references"
            keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

            opts.desc = "Go to declaration"
            keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

            opts.desc = "Show LSP definitions"
            keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

            opts.desc = "Show LSP implementations"
            keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

            opts.desc = "Show LSP type definitions"
            keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

            opts.desc = "See available code actions"
            keymap.set({ "n", "v" }, "<leader>ga", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

            opts.desc = "Smart rename"
            keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

            opts.desc = "Show buffer diagnostics"
            keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

            opts.desc = "Show line diagnostics"
            keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

            -- opts.desc = "Go to previous diagnostic"
            -- keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
            --
            -- opts.desc = "Go to next diagnostic"
            -- keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

            opts.desc = "Show documentation for what is under cursor"
            keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

            opts.desc = "Restart LSP"
            keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
        end

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Change the Diagnostic symbols in the sign column (gutter)
        -- (not in youtube nvim video)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        -- configure html server
        lspconfig["html"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure typescript server with plugin
        lspconfig["tsserver"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- -- configure emmet language server
        -- lspconfig["emmet_ls"].setup({
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        --     filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        -- })

        -- configure css server
        lspconfig["cssls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure tailwindcss server
        lspconfig["tailwindcss"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure svelte server
        lspconfig["svelte"].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)

                vim.api.nvim_create_autocmd("BufWritePost", {
                    pattern = { "*.js", "*.ts" },
                    callback = function(ctx)
                        if client.name == "svelte" then
                            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
                        end
                    end,
                })
            end,
        })

        -- configure prisma orm server
        lspconfig["prismals"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure graphql language server
        lspconfig["graphql"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
            root_dir = function(fname)
                return lspconfig.util.path.dirname(fname)
            end
        })

        -- configure python server
        lspconfig["pyright"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure go server
        lspconfig["gopls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure rust server
        lspconfig["rust_analyzer"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure terraform server
        lspconfig["terraformls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure yaml server
        lspconfig["yamlls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        --
        -- configure omnisharp server
        lspconfig["omnisharp"].setup({
            cmd = { "dotnet", "/home/mike/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },
            handlers = {
                ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
                ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
                ["textDocument/references"] = require('omnisharp_extended').references_handler,
                ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
            },
            settings = {
                FormattingOptions = {
                    -- Enables support for reading code style, naming convention and analyzer
                    -- settings from .editorconfig.
                    EnableEditorConfigSupport = true,
                    -- Specifies whether 'using' directives should be grouped and sorted during
                    -- document formatting.
                    OrganizeImports = true,
                },
                MsBuild = {
                    -- If true, MSBuild project system will only load projects for files that
                    -- were opened in the editor. This setting is useful for big C# codebases
                    -- and allows for faster initialization of code navigation features only
                    -- for projects that are relevant to code that is being edited. With this
                    -- setting enabled OmniSharp may load fewer projects and may thus display
                    -- incomplete reference lists for symbols.
                    LoadProjectsOnDemand = true,
                },
                RoslynExtensionsOptions = {
                    -- Enables support for roslyn analyzers, code fixes and rulesets.
                    EnableAnalyzersSupport = true,
                    -- Enables support for showing unimported types and unimported extension
                    -- methods in completion lists. When committed, the appropriate using
                    -- directive will be added at the top of the current file. This option can
                    -- have a negative impact on initial completion responsiveness,
                    -- particularly for the first few completion sessions after opening a
                    -- solution.
                    EnableImportCompletion = true,
                    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
                    -- true
                    AnalyzeOpenDocumentsOnly = nil,
                },
                Sdk = {
                    -- Specifies whether to include preview versions of the .NET SDK when
                    -- determining which version to use for project loading.
                    IncludePrereleases = true,
                },
                inlayHintsOptions = {
                    enableForParameters = true,
                    forLiteralParameters = true,
                    forIndexerParameters = true,
                    forObjectCreationParameters = true,
                    forOtherParameters = true,
                    suppressForParametersThatDifferOnlyBySuffix = false,
                    suppressForParametersThatMatchMethodIntent = false,
                    suppressForParametersThatMatchArgumentName = false,
                    enableForTypes = true,
                    forImplicitVariableTypes = true,
                    forLambdaParameterTypes = true,
                    forImplicitObjectCreation = true
                }
            },
        })

        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = { -- custom settings for lua
                Lua = {
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim", "kong", "ngx" },
                    },
                    workspace = {
                        -- make language server aware of runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })
    end,
}
