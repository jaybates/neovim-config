-- =============================================================================
-- Core Neovim Configuration
-- =============================================================================
-- This file loads all core Neovim settings and configurations

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

-- Auto-install dependencies if missing (with user confirmation)
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.defer_fn(function()
            dependency_installer.auto_install()
        end, 1000) -- Wait 1 second after startup
    end,
})