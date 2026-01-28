-- =============================================================================
-- Mason LSP Installer Configuration
-- =============================================================================
-- Mason is a portable package manager for Neovim that runs on Windows, Linux, and macOS
-- It manages LSP servers, DAP servers, linters, and formatters

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim", -- Bridge between Mason and lspconfig
    "WhoIsSethDaniel/mason-tool-installer.nvim", -- Install additional tools
  },
  config = function()
    -- =============================================================================
    -- PLUGIN IMPORTS
    -- =============================================================================
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    -- =============================================================================
    -- MASON SETUP
    -- =============================================================================
    mason.setup({
      -- =============================================================================
      -- UI CONFIGURATION
      -- =============================================================================
      ui = {
        border = "rounded", -- Border style for Mason windows
        icons = {
          package_installed = "✓",    -- Icon for installed packages
          package_pending = "➜",      -- Icon for pending installations
          package_uninstalled = "✗",  -- Icon for uninstalled packages
        },
        keymaps = {
          toggle_package_expand = "<CR>",
          install_package = "i",
          update_package = "u",
          check_package_version = "c",
          update_all_packages = "U",
          check_outdated_packages = "C",
          uninstall_package = "X",
          cancel_installation = "<C-c>",
          apply_language_filter = "<C-f>",
        },
      },
      
      -- =============================================================================
      -- INSTALLATION OPTIONS
      -- =============================================================================
      install_root_dir = vim.fn.stdpath("data") .. "/mason",
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
      github = {
        download_url_template = "https://github.com/%s/releases/download/%s/%s",
      },
    })

    -- =============================================================================
    -- MASON LSPCONFIG SETUP
    -- =============================================================================
    mason_lspconfig.setup({
      -- =============================================================================
      -- LANGUAGE SERVERS TO INSTALL
      -- =============================================================================
      ensure_installed = {
        -- Web Development
        "ts_ls",           -- TypeScript/JavaScript language server (formerly tsserver)
        "html",            -- HTML language server
        "cssls",           -- CSS language server
        "tailwindcss",     -- Tailwind CSS language server
        "emmet_ls",        -- Emmet language server for HTML/CSS
        
        -- Backend Development
        "lua_ls",          -- Lua language server
        "graphql",         -- GraphQL language server
        "jsonls",          -- JSON language server
        "yamlls",          -- YAML language server
        
        -- Additional Languages (uncomment as needed)
        -- "pyright",       -- Python language server
        -- "gopls",         -- Go language server
        -- "rust_analyzer", -- Rust language server
        -- "clangd",        -- C/C++ language server
      },
      
      -- =============================================================================
      -- AUTOMATIC SERVER SETUP
      -- =============================================================================
      automatic_installation = true, -- Automatically install servers when needed
    })

    -- =============================================================================
    -- MASON TOOL INSTALLER SETUP
    -- =============================================================================
    mason_tool_installer.setup({
      -- =============================================================================
      -- FORMATTERS & LINTERS TO INSTALL
      -- =============================================================================
      ensure_installed = {
        -- =============================================================================
        -- WEB DEVELOPMENT FORMATTERS
        -- =============================================================================
        "prettier",        -- Universal code formatter
        "prettierd",       -- Prettier daemon (faster)
        "eslint_d",        -- JavaScript/TypeScript linter (daemonized)
        "stylelint",       -- CSS/SCSS linter
        "htmlhint",        -- HTML linter
        "jsonlint",        -- JSON linter
        "yamllint",        -- YAML linter
        
        -- =============================================================================
        -- BACKEND FORMATTERS
        -- =============================================================================
        "stylua",          -- Lua formatter
        "black",           -- Python formatter
        "isort",           -- Python import sorter
        "flake8",          -- Python linter
        "pylint",          -- Python linter
        "gofumpt",         -- Go formatter
        "golangci_lint",   -- Go linter
        "rustfmt",         -- Rust formatter
        "cargo_check",     -- Rust linter
        
        -- =============================================================================
        -- SHELL & SCRIPTING
        -- =============================================================================
        "shellcheck",      -- Shell script linter
        "shfmt",           -- Shell formatter
        "luacheck",        -- Lua linter
        
        -- =============================================================================
        -- ADDITIONAL WEB DEV TOOLS
        -- =============================================================================
        "typescript-language-server", -- TypeScript LSP
        "tailwindcss-language-server", -- Tailwind CSS LSP
        "volar",           -- Vue Language Server
        "svelte-language-server", -- Svelte LSP
        "emmet-ls",        -- Emmet language server
        "css-lsp",         -- CSS language server
        "html-lsp",        -- HTML language server
        "json-lsp",        -- JSON language server
        "yaml-language-server", -- YAML LSP
      },
      
      -- =============================================================================
      -- AUTO-UPDATE SETTINGS
      -- =============================================================================
      auto_update = false, -- Don't auto-update tools (manual control)
      run_on_start = true, -- Run installation check on startup
    })
  end,
}