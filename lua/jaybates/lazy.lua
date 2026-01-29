-- =============================================================================
-- Lazy.nvim Plugin Manager Configuration
-- =============================================================================
-- Load order: init.lua → jaybates → core (options, keyremaps, keymaps, dependency_installer)
--            → lazy (this file). Plugins load by priority then by event/cmd/keys.
-- Priority order (higher = earlier): plenary 1000, colorscheme 1000, Mason 200,
--            treesitter 150, nvim-lspconfig 100. Rest use default (50).

-- =============================================================================
-- LAZY.NVIM INSTALLATION
-- =============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- LAZY.NVIM SETUP (import order: plugins first, then lsp so base deps load first)
-- =============================================================================
require("lazy").setup({
  { import = "jaybates.plugins" },
  { import = "jaybates.plugins.lsp" },
}, {
  -- =============================================================================
  -- PERFORMANCE & OPTIMIZATION
  -- =============================================================================
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- Reset the package path to improve startup time
    rtp = {
      reset = true, -- Reset the runtime path to improve startup time
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },

  -- =============================================================================
  -- PLUGIN MANAGEMENT
  -- =============================================================================
  checker = {
    enabled = true,        -- Automatically check for plugin updates
    notify = false,        -- Don't notify about updates (can be noisy)
    frequency = 604800,    -- Check for updates once a week (in seconds)
  },
  
  change_detection = {
    enabled = true,        -- Detect changes to plugin configurations
    notify = false,        -- Don't notify about configuration changes
  },

  -- =============================================================================
  -- UI CUSTOMIZATION
  -- =============================================================================
  ui = {
    -- Customize the lazy.nvim UI
    border = "rounded",    -- Use rounded borders for better aesthetics
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📋",
      lazy = "💤 ",
    },
  },

  -- =============================================================================
  -- DEBUGGING
  -- =============================================================================
  debug = false, -- Set to true to enable debug mode
})