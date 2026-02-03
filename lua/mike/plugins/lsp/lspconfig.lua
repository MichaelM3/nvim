return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "williamboman/mason-lspconfig.nvim" },
  },
  config = function()
    -- Use configs directly to avoid deprecation warning in nvim-lspconfig v1.0+
    local configs = require("lspconfig.configs")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local capabilities = cmp_nvim_lsp.default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- Register LSP configs with Neovim 0.12 native API so checkhealth sees them
    if vim.lsp and vim.lsp.config then
      local register = function(name, opts)
        pcall(vim.lsp.config, name, vim.tbl_extend("keep", opts or {}, { capabilities = capabilities }))
      end
      register("cssls")
      register("emmet_ls", { filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" } })
      register("gopls")
      register("graphql", { filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" } })
      register("html")
      register("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim", "kong", "ngx" } },
            workspace = { library = { [vim.fn.expand("$VIMRUNTIME/lua")] = true, [vim.fn.stdpath("config") .. "/lua"] = true } },
          },
        },
      })
      register("prismals")
      register("pyright")
      register("ruby_lsp")
      register("rust_analyzer")
      register("tailwindcss")
      register("ts_ls", { init_options = { preferences = { disableSuggestions = false } } })
      -- stylua is a formatter, not LSP; register only if 0.12 treats it as config
      pcall(vim.lsp.config, "stylua", { capabilities = capabilities })
    end

    -- Create an autocommand for LspAttach to set keybinds
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local keymap = vim.keymap

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
      end,
    })

    -- Configure diagnostic signs
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    vim.diagnostic.config({
      severity_sort = true,
      virtual_text = { severity = vim.diagnostic.severity.WARN },
      underline = true,
      update_in_insert = false,
    })

    -- Explicitly define handlers
    local handlers = {
      -- Default handler
      function(server_name)
        local config = configs[server_name]
        if config then
          config.setup({
            capabilities = capabilities,
          })
        end
      end,

      ["ts_ls"] = function()
        configs.ts_ls.setup({
          capabilities = capabilities,
          init_options = {
            preferences = {
              disableSuggestions = false,
            },
          },
        })
      end,

      ["graphql"] = function()
        configs.graphql.setup({
          capabilities = capabilities,
          filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        })
      end,

      ["emmet_ls"] = function()
        configs.emmet_ls.setup({
          capabilities = capabilities,
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        })
      end,

      ["lua_ls"] = function()
        configs.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = { globals = { "vim", "kong", "ngx" } },
              workspace = {
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

    -- Manually trigger setup_handlers if available, or iterate installed servers if not
    if mason_lspconfig.setup_handlers then
      mason_lspconfig.setup_handlers(handlers)
    else
      -- Fallback: Iterate over installed servers and apply handlers manually
      local installed_servers = mason_lspconfig.get_installed_servers()
      for _, server_name in ipairs(installed_servers) do
        -- Ensure config is loaded
        if not configs[server_name] then
          pcall(require, "lspconfig.configs." .. server_name)
        end

        -- Only run handler if we have a valid LSP config (skips non-LSP tools like stylua)
        if configs[server_name] then
          local handler = handlers[server_name] or handlers[1]
          handler(server_name)
        end
      end
    end
  end,
}
