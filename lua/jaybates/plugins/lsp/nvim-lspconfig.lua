return {
  "neovim/nvim-lspconfig",
  priority = 100, -- After Mason (200); LSP config runs when buffer opens
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim", -- LSP server list + handlers; load before requiring
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- Our configuration uses the new vim.lsp.config API (Neovim 0.11+)
    -- typescript-tools.nvim handles ts_ls configuration and supports the new API

    -- import mason_lspconfig plugin
    local mason_lspconfig = require("mason-lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

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
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Diagnostic config: signs + performance (no updates while typing, virtual text only for WARN+)
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN]  = " ",
          [vim.diagnostic.severity.HINT]  = " ",
          [vim.diagnostic.severity.INFO]  = " ",
        },
      },
      update_in_insert = false,   -- Don't refresh diagnostics while typing (lighter)
      virtual_text = { severity = { min = vim.diagnostic.severity.WARN } }, -- Only show inline text for WARN/ERROR
    })

    -- LSP server list lives here to avoid mason.lua requiring mason-lspconfig (load loop)
    mason_lspconfig.setup({
      ensure_installed = {
        "ts_ls", "html", "cssls", "tailwindcss", "emmet_ls",
        "graphql", "jsonls", "yamlls",
        "lua_ls", "pyright", "gopls", "intelephense",
        "dockerls", "terraformls",
      },
      automatic_installation = true,
      handlers = {
        -- Default handler for installed servers
        function(server_name)
          if server_name == "ts_ls" or server_name == "tsserver" then
            return
          end
          local config = vim.lsp.config[server_name]
          if config then
            config.setup({ capabilities = capabilities })
          end
        end,
        ["ts_ls"] = function() end,
        ["tsserver"] = function() end,
        ["graphql"] = function()
          vim.lsp.config.graphql.setup({
            capabilities = capabilities,
            filetypes = { "graphql", "gql", "typescriptreact", "javascriptreact" },
          })
        end,
        ["emmet_ls"] = function()
          vim.lsp.config.emmet_ls.setup({
            capabilities = capabilities,
            filetypes = { "html", "htmldjango", "php", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
          })
        end,
        ["lua_ls"] = function()
          vim.lsp.config.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
                completion = { callSnippet = "Replace" },
              },
            },
          })
        end,
        ["jsonls"] = function()
          local schemastore_ok, schemastore = pcall(require, "schemastore")
          local jsonls_config = { capabilities = capabilities }
          if schemastore_ok then
            jsonls_config.settings = {
              json = { schemas = schemastore.json.schemas(), validate = { enable = true } },
            }
          end
          require("lspconfig").jsonls.setup(jsonls_config)
        end,
      },
    })
  end,
}