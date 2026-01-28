-- =============================================================================
-- Advanced Key Mappings Configuration
-- =============================================================================
-- This file contains advanced key mappings for various plugins and functionality
-- Organized by category for better maintainability

-- =============================================================================
-- PLUGIN-SPECIFIC KEY MAPPINGS
-- =============================================================================

-- =============================================================================
-- TELESCOPE KEY MAPPINGS
-- =============================================================================
local function setup_telescope_mappings()
  -- Check if telescope is available
  local telescope_ok, builtin = pcall(require, 'telescope.builtin')
  if not telescope_ok then
    vim.notify("Telescope not available, skipping telescope keymaps", "warn")
    return
  end
  
  local keymap = vim.keymap

  -- File operations
  keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
  keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
  keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
  keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
  keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent files" })
  keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find string under cursor" })
  
  -- Git operations
  keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
  keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git branches" })
  keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })
  
  -- LSP operations
  keymap.set("n", "<leader>gd", builtin.lsp_definitions, { desc = "LSP definitions" })
  keymap.set("n", "<leader>gr", builtin.lsp_references, { desc = "LSP references" })
  keymap.set("n", "<leader>gi", builtin.lsp_implementations, { desc = "LSP implementations" })
  keymap.set("n", "<leader>gt", builtin.lsp_type_definitions, { desc = "LSP type definitions" })
  keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "LSP document symbols" })
  keymap.set("n", "<leader>ws", builtin.lsp_workspace_symbols, { desc = "LSP workspace symbols" })
end

-- =============================================================================
-- TROUBLE KEY MAPPINGS
-- =============================================================================
local function setup_trouble_mappings()
  local trouble_ok = pcall(require, 'trouble')
  if not trouble_ok then
    vim.notify("Trouble not available, skipping trouble keymaps", "warn")
    return
  end
  
  local keymap = vim.keymap
  
  keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<CR>", { desc = "Toggle trouble" })
  keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "Workspace diagnostics" })
  keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", { desc = "Document diagnostics" })
  keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", { desc = "Quickfix list" })
  keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<CR>", { desc = "Location list" })
  keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<CR>", { desc = "Todo trouble" })
end

-- =============================================================================
-- HARPOON KEY MAPPINGS
-- =============================================================================
local function setup_harpoon_mappings()
  local harpoon_ok = pcall(require, 'harpoon')
  if not harpoon_ok then
    vim.notify("Harpoon not available, skipping harpoon keymaps", "warn")
    return
  end
  
  local keymap = vim.keymap
  
  keymap.set("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>", { desc = "Add file to harpoon" })
  keymap.set("n", "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", { desc = "Toggle harpoon menu" })
  keymap.set("n", "<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", { desc = "Navigate to file 1" })
  keymap.set("n", "<leader>h2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", { desc = "Navigate to file 2" })
  keymap.set("n", "<leader>h3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", { desc = "Navigate to file 3" })
  keymap.set("n", "<leader>h4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", { desc = "Navigate to file 4" })
end

-- =============================================================================
-- LSP KEY MAPPINGS
-- =============================================================================
local function setup_lsp_mappings()
  local keymap = vim.keymap
  
  -- LSP actions
  keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
  keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
  keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
  keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", { desc = "Restart LSP" })
  
  -- Diagnostics
  keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
  keymap.set("n", "<leader>D", function()
    local telescope_ok, builtin = pcall(require, 'telescope.builtin')
    if telescope_ok then
      builtin.diagnostics({ bufnr = 0 })
    else
      vim.diagnostic.open_float()
    end
  end, { desc = "Show buffer diagnostics" })
  keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
  keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
end

-- =============================================================================
-- FORMATTING KEY MAPPINGS
-- =============================================================================
local function setup_formatting_mappings()
  local conform_ok = pcall(require, 'conform')
  if not conform_ok then
    vim.notify("Conform not available, skipping formatting keymaps", "warn")
    return
  end
  
  local keymap = vim.keymap
  
  keymap.set("n", "<leader>mp", function()
    require("conform").format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 1000,
    })
  end, { desc = "Format file" })
  
  keymap.set("v", "<leader>mp", function()
    require("conform").format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 1000,
    })
  end, { desc = "Format selection" })
end

-- =============================================================================
-- COMMENT KEY MAPPINGS
-- =============================================================================
local function setup_comment_mappings()
  local comment_ok = pcall(require, 'Comment.api')
  if not comment_ok then
    vim.notify("Comment not available, skipping comment keymaps", "warn")
    return
  end
  
  local keymap = vim.keymap
  
  keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", { desc = "Toggle comment" })
  keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle comment" })
end

-- =============================================================================
-- SUBSTITUTE KEY MAPPINGS
-- =============================================================================
local function setup_substitute_mappings()
  local substitute_ok = pcall(require, 'substitute')
  if not substitute_ok then
    vim.notify("Substitute not available, skipping substitute keymaps", "warn")
    return
  end
  
  local keymap = vim.keymap
  
  keymap.set("n", "s", "<cmd>lua require('substitute').operator()<CR>", { desc = "Substitute with motion" })
  keymap.set("n", "ss", "<cmd>lua require('substitute').line()<CR>", { desc = "Substitute line" })
  keymap.set("n", "S", "<cmd>lua require('substitute').eol()<CR>", { desc = "Substitute to end of line" })
  keymap.set("x", "s", "<cmd>lua require('substitute').visual()<CR>", { desc = "Substitute in visual mode" })
end

-- =============================================================================
-- TODO COMMENTS KEY MAPPINGS
-- =============================================================================
local function setup_todo_mappings()
  local todo_ok = pcall(require, 'todo-comments')
  if not todo_ok then
    vim.notify("Todo-comments not available, skipping todo keymaps", "warn")
    return
  end
  
  local keymap = vim.keymap
  
  keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
  end, { desc = "Next todo comment" })
  
  keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
  end, { desc = "Previous todo comment" })
end

-- =============================================================================
-- INITIALIZE ALL MAPPINGS
-- =============================================================================
local function setup_all_mappings()
  setup_telescope_mappings()
  setup_trouble_mappings()
  setup_harpoon_mappings()
  setup_lsp_mappings()
  setup_formatting_mappings()
  setup_comment_mappings()
  setup_substitute_mappings()
  setup_todo_mappings()
end

-- Set up mappings when this module is loaded
-- Use a deferred call to ensure plugins are loaded
vim.defer_fn(setup_all_mappings, 100)

return {
  setup_telescope_mappings = setup_telescope_mappings,
  setup_trouble_mappings = setup_trouble_mappings,
  setup_harpoon_mappings = setup_harpoon_mappings,
  setup_lsp_mappings = setup_lsp_mappings,
  setup_formatting_mappings = setup_formatting_mappings,
  setup_comment_mappings = setup_comment_mappings,
  setup_substitute_mappings = setup_substitute_mappings,
  setup_todo_mappings = setup_todo_mappings,
}
