-- =============================================================================
-- Core Neovim Configuration
-- =============================================================================
-- This file loads all core Neovim settings and configurations

-- =============================================================================
-- LSP DEPRECATION SHIM (run before plugins load)
-- =============================================================================
-- Plugins may still call vim.lsp.buf_get_clients(); redirect to the new API
-- so the deprecation warning goes away until those plugins are updated.
if vim.lsp and vim.lsp.buf_get_clients then
  vim.lsp.buf_get_clients = function(bufnr)
    return vim.lsp.get_clients({ bufnr = bufnr or 0 })
  end
end

-- =============================================================================
-- CORE MODULES
-- =============================================================================
require("jaybates.core.options")    -- Neovim options and settings
require("jaybates.core.keyremaps")  -- Basic key mappings
require("jaybates.core.keymaps")    -- Advanced plugin key mappings

-- =============================================================================
-- DEPENDENCY INSTALLER
-- =============================================================================
-- Auto-install external dependencies on startup
local dependency_installer = require("jaybates.core.dependency_installer")
dependency_installer.setup_commands()

-- Auto-install dependencies if missing (with user confirmation).
-- Skip when opening with no file so the dashboard stays visible.
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        if vim.fn.argc() == 0 then
            return -- Dashboard mode: don't run and risk replacing the dashboard
        end
        vim.defer_fn(function()
            dependency_installer.auto_install()
        end, 1000)
    end,
})

-- =============================================================================
-- PROJECT LAYOUT: [nvim-tree | placeholder] when opening a directory
-- =============================================================================
-- When you open a project with `nvim .` or `nvim project-dir`, open nvim-tree
-- and a placeholder buffer so the layout is stable. Opening a file from Telescope
-- then replaces the placeholder (no resize/flash).
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        if vim.fn.argc() ~= 1 then return end
        local arg = vim.fn.argv(0)
        if arg == "" or vim.fn.isdirectory(arg) ~= 1 then return end

        vim.defer_fn(function()
            local ok, api = pcall(require, "nvim-tree.api")
            if not ok or not api then return end

            api.tree.open()
            vim.schedule(function()
                local wins = vim.api.nvim_list_wins()
                if #wins == 1 then
                    vim.cmd("vsplit")
                    vim.cmd("enew")
                end
            end)
        end, 150)
    end,
})