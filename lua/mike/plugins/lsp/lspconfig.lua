return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

    -- Enable snippet support for completion
    local capabilities = cmp_nvim_lsp.default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- Define on_attach function for LSP keymaps
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, noremap = true, silent = true }

      -- Keybindings
      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ga", vim.lsp.buf.code_action, opts)
      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts)
      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

      -- Format on save if supported
      if client:supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({
          group = vim.api.nvim_create_augroup("Format", { clear = true }),
          buffer = bufnr,
        })
        -- vim.api.nvim_create_autocmd("BufWritePre", {
        --   group = vim.api.nvim_create_augroup("Format", { clear = true }),
        --   buffer = bufnr,
        --   callback = function()
        --     vim.lsp.buf.format()
        --   end,
        -- })
      end
    end

    -- Configure diagnostic signs
    vim.diagnostic.config({
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
      virtual_text = { severity = vim.diagnostic.severity.WARN },
      underline = true,
      update_in_insert = false,
    })

    -- Configure LSP servers
    lspconfig.html.setup({
      cmd = { 'vscode-html-language-server', '--stdio' },
      filetypes = { 'html' },
      root_markers = { 'index.html', '.git' },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.ts_ls.setup({
      cmd = { 'typescript-language-server', '--stdio' },
      filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
      root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
      init_options = {
        preferences = {
          disableSuggestions = false,
        },
      },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.cssls.setup({
      cmd = { 'vscode-css-language-server', '--stdio' },
      filetypes = { 'css', 'scss', 'less' },
      root_markers = { 'package.json', '.git' },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.tailwindcss.setup({
      cmd = { 'tailwindcss-language-server', '--stdio' },
      filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
      root_markers = { 'tailwind.config.js', 'tailwind.config.cjs', 'package.json', '.git' },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.graphql.setup({
      cmd = { 'graphql-lsp', 'server', '-m', 'stream' },
      filetypes = { 'graphql', 'gql', 'svelte', 'typescriptreact', 'javascriptreact' },
      root_markers = { lspconfig.util.path.dirname },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.pyright.setup({
      cmd = { 'pyright-langserver', '--stdio' },
      filetypes = { 'python' },
      root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.gopls.setup({
      cmd = { 'gopls' },
      filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
      root_markers = { 'go.work', 'go.mod', '.git' },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.rust_analyzer.setup({
      cmd = { 'rust-analyzer' },
      filetypes = { 'rust' },
      root_markers = { 'Cargo.toml', '.git' },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.terraformls.setup({
      cmd = { 'terraform-ls', 'serve' },
      filetypes = { 'terraform', 'tf' },
      root_markers = { 'main.tf', '.terraform', '.git' },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.yamlls.setup({
      cmd = { 'yaml-language-server', '--stdio' },
      filetypes = { 'yaml', 'yaml.docker-compose' },
      root_markers = { '.git' },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.lua_ls.setup({
      cmd = { 'lua-language-server' },
      filetypes = { 'lua' },
      root_markers = {
        '.luarc.json',
        '.luarc.jsonc',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        'selene.toml',
        'selene.yml',
        '.git',
      },
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim', 'kong', 'ngx' } },
          workspace = {
            library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.stdpath('config') .. '/lua'] = true,
            },
          },
        },
      },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.marksman.setup({
      cmd = { 'marksman', 'server' },
      filetypes = { 'markdown' },
      root_markers = { '.git' },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.ruby_lsp.setup({
      cmd = { 'ruby-lsp' },
      filetypes = { 'ruby', 'erb' },
      root_markers = { 'Gemfile', 'Rakefile', '.git' },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Ensure nvim-lsp-file-operations is configured
    require("lsp-file-operations").setup()
  end,
}
