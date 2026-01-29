-- =============================================================================
-- Mason LSP Installer Configuration
-- =============================================================================
-- Mason is a portable package manager for Neovim that runs on Windows, Linux, and macOS
-- It manages LSP servers, DAP servers, linters, and formatters

return {
  "williamboman/mason.nvim",
  priority = 200, -- Before nvim-lspconfig so Mason is ready when LSP attaches
  dependencies = {
    "williamboman/mason-lspconfig.nvim", -- Bridge (configured in nvim-lspconfig.lua to avoid load loop)
    "WhoIsSethDaniel/mason-tool-installer.nvim", -- Install additional tools
  },
  config = function()
    local mason = require("mason")
    local mason_tool_installer = require("mason-tool-installer")

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

    -- LSP server list is in nvim-lspconfig.lua (mason_lspconfig.setup) to avoid load loop
    -- =============================================================================
    -- MASON TOOL INSTALLER SETUP
    -- =============================================================================
    mason_tool_installer.setup({
      -- =============================================================================
      -- FORMATTERS & LINTERS TO INSTALL (stylelint: install with npm i -g stylelint if needed)
      -- =============================================================================
      ensure_installed = {
        -- Web: React, JS, Node
        "prettier",
        "prettierd",
        "eslint_d",
        "htmlhint",
        -- Data
        "jsonlint",
        "yamllint",
        -- Backend
        "stylua",
        "black",
        "isort",
        "flake8",
        "pylint",
        "gofumpt",
        "golangci-lint",
        -- PHP, Docker, Terraform, SQL
        "phpcs",           -- PHP code standards (lint)
        "hadolint",        -- Dockerfile linter
        "sqlfluff",        -- SQL formatter/linter
        -- Shell & config
        "shellcheck",
        "shfmt",
        "luacheck",
      },
      
      -- =============================================================================
      -- AUTO-UPDATE SETTINGS
      -- =============================================================================
      auto_update = false, -- Don't auto-update tools (manual control)
      run_on_start = true, -- Run installation check on startup
    })
  end,
}