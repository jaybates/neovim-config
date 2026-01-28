-- =============================================================================
-- Session Management Configuration
-- =============================================================================
-- Session management for Neovim with automatic saving and loading
-- Provides session persistence across Neovim restarts

return {
  "Shatur/neovim-session-manager",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local session_manager = require("session_manager")
    local config = require("session_manager.config")

    -- =============================================================================
    -- SESSION CONFIGURATION
    -- =============================================================================
    session_manager.setup({
      -- =============================================================================
      -- SESSION DIRECTORY
      -- =============================================================================
      sessions_dir = vim.fn.stdpath("data") .. "/sessions/",
      
      -- =============================================================================
      -- SESSION OPTIONS
      -- =============================================================================
      autoload_mode = config.AutoloadMode.Disabled, -- Don't auto-load sessions
      autosave_last_session = true, -- Auto-save last session
      autosave_ignore_not_normal = true, -- Ignore non-normal buffers
      autosave_ignore_dirs = { -- Directories to ignore
        "~/",
        "~/Projects",
        "~/Downloads",
        "/",
      },
      autosave_ignore_filetypes = { -- File types to ignore
        "alpha",
        "dashboard",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      autosave_ignore_buftypes = { -- Buffer types to ignore
        "terminal",
        "quickfix",
        "help",
        "nofile",
      },
      autosave_only_in_session = false, -- Save only when in a session
      max_path_length = 80, -- Maximum path length
    })

    -- =============================================================================
    -- KEY MAPPINGS
    -- =============================================================================
    vim.keymap.set("n", "<leader>ss", "<cmd>SessionManager save_current_session<CR>", { desc = "Save current session" })
    vim.keymap.set("n", "<leader>sl", "<cmd>SessionManager load_last_session<CR>", { desc = "Load last session" })
    vim.keymap.set("n", "<leader>sd", "<cmd>SessionManager delete_session<CR>", { desc = "Delete session" })
    vim.keymap.set("n", "<leader>sf", "<cmd>SessionManager load_session<CR>", { desc = "Load session" })
    vim.keymap.set("n", "<leader>sS", "<cmd>SessionManager save_session<CR>", { desc = "Save session" })

    -- =============================================================================
    -- AUTOCMDS
    -- =============================================================================
    local group = vim.api.nvim_create_augroup("SessionManager", { clear = true })

    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "SessionLoadPost",
      group = group,
      callback = function()
        vim.notify("Session loaded successfully!", vim.log.levels.INFO)
      end,
    })

    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "SessionSavePost",
      group = group,
      callback = function()
        vim.notify("Session saved successfully!", vim.log.levels.INFO)
      end,
    })
  end,
}
