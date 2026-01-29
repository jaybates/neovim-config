-- =============================================================================
-- Advanced Key Mappings Configuration
-- =============================================================================
-- This file contains advanced key mappings for various plugins and functionality
-- Organized by category for better maintainability

-- =============================================================================
-- PLUGIN-SPECIFIC KEY MAPPINGS
-- =============================================================================

-- =============================================================================
-- TELESCOPE KEY MAPPINGS (cmd strings so Telescope loads on first use)
-- =============================================================================
local function setup_telescope_mappings()
  local keymap = vim.keymap
  -- File operations
  keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
  keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
  keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
  keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help tags" })
  keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })
  keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor" })
  -- Git operations
  keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
  keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })
  keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
  -- LSP operations
  keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "LSP definitions" })
  keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<cr>", { desc = "LSP references" })
  keymap.set("n", "<leader>gi", "<cmd>Telescope lsp_implementations<cr>", { desc = "LSP implementations" })
  keymap.set("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "LSP type definitions" })
  keymap.set("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "LSP document symbols" })
  keymap.set("n", "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "LSP workspace symbols" })
end

-- =============================================================================
-- TROUBLE KEY MAPPINGS (cmd strings so Trouble loads on first use)
-- =============================================================================
local function setup_trouble_mappings()
  local keymap = vim.keymap
  keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle trouble" })
  keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace diagnostics" })
  keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document diagnostics" })
  keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix list" })
  keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { desc = "Location list" })
  keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Todo trouble" })
end

-- =============================================================================
-- HARPOON KEY MAPPINGS (cmd strings so Harpoon loads on first use)
-- =============================================================================
local function setup_harpoon_mappings()
  local keymap = vim.keymap
  keymap.set("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = "Add file to harpoon" })
  keymap.set("n", "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { desc = "Toggle harpoon menu" })
  keymap.set("n", "<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { desc = "Navigate to file 1" })
  keymap.set("n", "<leader>h2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", { desc = "Navigate to file 2" })
  keymap.set("n", "<leader>h3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", { desc = "Navigate to file 3" })
  keymap.set("n", "<leader>h4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", { desc = "Navigate to file 4" })
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
  keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Show buffer diagnostics" })
  keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
  keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
end

-- =============================================================================
-- FORMATTING KEY MAPPINGS (cmd lua so Conform loads on first use)
-- =============================================================================
local function setup_formatting_mappings()
  local keymap = vim.keymap
  local fmt_cmd = "lua require('conform').format({ lsp_fallback = true, async = false, timeout_ms = 1000 })"
  keymap.set("n", "<leader>mp", "<cmd>" .. fmt_cmd .. "<cr>", { desc = "Format file" })
  keymap.set("v", "<leader>mp", "<cmd>" .. fmt_cmd .. "<cr>", { desc = "Format selection" })
end

-- =============================================================================
-- COMMENT KEY MAPPINGS (cmd lua so Comment loads on first use)
-- =============================================================================
local function setup_comment_mappings()
  local keymap = vim.keymap
  keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", { desc = "Toggle comment" })
  keymap.set("v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", { desc = "Toggle comment" })
end

-- =============================================================================
-- SUBSTITUTE KEY MAPPINGS (cmd lua so Substitute loads on first use)
-- =============================================================================
local function setup_substitute_mappings()
  local keymap = vim.keymap
  keymap.set("n", "s", "<cmd>lua require('substitute').operator()<cr>", { desc = "Substitute with motion" })
  keymap.set("n", "ss", "<cmd>lua require('substitute').line()<cr>", { desc = "Substitute line" })
  keymap.set("n", "S", "<cmd>lua require('substitute').eol()<cr>", { desc = "Substitute to end of line" })
  keymap.set("x", "s", "<cmd>lua require('substitute').visual()<cr>", { desc = "Substitute in visual mode" })
end

-- =============================================================================
-- TODO COMMENTS KEY MAPPINGS (cmd lua so Todo-comments loads on first use)
-- =============================================================================
local function setup_todo_mappings()
  local keymap = vim.keymap
  keymap.set("n", "]t", "<cmd>lua require('todo-comments').jump_next()<cr>", { desc = "Next todo comment" })
  keymap.set("n", "[t", "<cmd>lua require('todo-comments').jump_prev()<cr>", { desc = "Previous todo comment" })
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

-- Set up mappings after core is ready (keymaps use cmd strings so plugins load on first use)
vim.defer_fn(setup_all_mappings, 0)

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
