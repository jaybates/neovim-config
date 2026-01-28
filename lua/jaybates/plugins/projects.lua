-- =============================================================================
-- Projects Configuration
-- =============================================================================
-- Project management for Neovim with telescope integration

return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  config = function()
    require("project_nvim").setup({
      -- Manual mode only (no automatic detection)
      manual_mode = false,
      
      -- Detection methods
      detection_methods = { "lsp", "pattern" },
      
      -- Patterns to detect project root
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml", "Cargo.toml" },
      
      -- Exclude directories
      exclude_dirs = { "~/.cargo/*", "~/.*" },
      
      -- Show hidden files
      show_hidden = false,
      
      -- Silent mode
      silent_chdir = true,
      
      -- Scope
      scope_chdir = "global",
      
      -- Data path
      datapath = vim.fn.stdpath("data"),
    })

    -- Key mappings
    vim.keymap.set("n", "<leader>p", "<cmd>Telescope projects<CR>", { desc = "Projects" })
  end,
}
