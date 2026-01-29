-- =============================================================================
-- Key Mappings Configuration
-- =============================================================================
-- This file contains all custom key mappings and leader key setup
-- Leader key is set to space for easy access

-- =============================================================================
-- LEADER KEY SETUP
-- =============================================================================
vim.g.mapleader = " "                -- Set space as the leader key
vim.g.maplocalleader = " "           -- Set space as the local leader key

-- =============================================================================
-- GENERAL KEY MAPPINGS
-- =============================================================================

-- Clear search highlights with <Esc>
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows with arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines up and down
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move line down" })
vim.keymap.set("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- File explorer (netrw replacement)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

-- =============================================================================
-- BUFFER MANAGEMENT
-- =============================================================================
-- Switch between open files: Shift+h (previous buffer), Shift+l (next buffer).
-- Or click a buffer in the bufferline at the top. Window nav: Ctrl+h/j/k/l.

-- Buffer navigation
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
-- Close current buffer (only this buffer; use bufferline or Shift+h/l to switch)
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>ba", "<cmd>%bd<CR>", { desc = "Delete all buffers" })

-- =============================================================================
-- QUICK FIX LIST
-- =============================================================================

-- Quick fix list navigation
vim.keymap.set("n", "<C-q>", "<cmd>copen<CR>", { desc = "Open quick fix list" })
vim.keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "Next quick fix" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quick fix" })

-- =============================================================================
-- SEARCH & REPLACE
-- =============================================================================

-- Search and replace
vim.keymap.set("n", "<leader>sr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Search and replace word under cursor" })
vim.keymap.set("v", "<leader>sr", "y:%s/<C-r>\"//g<Left><Left>", { desc = "Search and replace selection" })

-- =============================================================================
-- UTILITY MAPPINGS
-- =============================================================================

-- Toggle line numbers
vim.keymap.set("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line numbers" })
vim.keymap.set("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle relative line numbers" })

-- Toggle word wrap
vim.keymap.set("n", "<leader>w", "<cmd>set wrap!<CR>", { desc = "Toggle word wrap" })

-- Toggle spell check
vim.keymap.set("n", "<leader>s", "<cmd>set spell!<CR>", { desc = "Toggle spell check" })

-- =============================================================================
-- TERMINAL MAPPINGS
-- =============================================================================

-- Terminal mode mappings
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Move to left window from terminal" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move to below window from terminal" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move to above window from terminal" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move to right window from terminal" })
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", { desc = "Window navigation from terminal" })
vim.keymap.set("t", "<C-q>", "<C-\\><C-n>:q<cr>", { desc = "Quit from terminal" })

-- Terminal operations
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal" })
vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Toggle horizontal terminal" })
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Toggle vertical terminal" })

-- Multiple terminals
vim.keymap.set("n", "<leader>t1", "<cmd>1ToggleTerm<cr>", { desc = "Toggle terminal 1" })
vim.keymap.set("n", "<leader>t2", "<cmd>2ToggleTerm<cr>", { desc = "Toggle terminal 2" })
vim.keymap.set("n", "<leader>t3", "<cmd>3ToggleTerm<cr>", { desc = "Toggle terminal 3" })
vim.keymap.set("n", "<leader>t4", "<cmd>4ToggleTerm<cr>", { desc = "Toggle terminal 4" })

-- Specialized terminals (LazyGit: <leader>gg from lazygit.nvim in terminal-extras)
vim.keymap.set("n", "<leader>tn", function()
    local Terminal = require("toggleterm.terminal").Terminal
    local node_terminal = Terminal:new({ direction = "float" })
    node_terminal:toggle()
end, { desc = "Toggle node REPL" })
vim.keymap.set("n", "<leader>tp", function()
    local Terminal = require("toggleterm.terminal").Terminal
    local python_terminal = Terminal:new({ direction = "float" })
    python_terminal:toggle()
end, { desc = "Toggle python REPL" })
