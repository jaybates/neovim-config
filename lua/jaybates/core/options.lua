-- =============================================================================
-- Neovim Core Options Configuration
-- =============================================================================
-- This file contains all the core Neovim options and settings
-- Use `:h <option>` to understand any option's purpose

-- =============================================================================
-- CLIPBOARD & SYSTEM INTEGRATION
-- =============================================================================
vim.opt.clipboard = 'unnamedplus'   -- Use system clipboard for all operations
vim.opt.mouse = 'a'                 -- Enable mouse support in all modes

-- =============================================================================
-- SHELL (login shell so embedded terminal gets nvm, etc. from .zshrc)
-- =============================================================================
vim.opt.shellcmdflag = "-l -c"     -- Run shell as login shell (sources .zshrc/.bash_profile)

-- =============================================================================
-- COMPLETION & AUTOCOMPLETE
-- =============================================================================
vim.opt.completeopt = {'menu', 'menuone', 'noselect'} -- Better completion menu behavior

-- =============================================================================
-- INDENTATION & TABS
-- =============================================================================
vim.opt.tabstop = 2                 -- Number of visual spaces per TAB
vim.opt.softtabstop = 2             -- Number of spaces in tab when editing
vim.opt.shiftwidth = 2              -- Number of spaces to use for autoindent
vim.opt.expandtab = true            -- Convert tabs to spaces (better for most languages)
vim.opt.smartindent = true          -- Smart autoindenting when starting a new line
vim.opt.autoindent = true           -- Copy indent from current line when starting a new line

-- =============================================================================
-- UI & DISPLAY
-- =============================================================================
-- Font (GUI only). #e = edge/antialiasing, #h = hinting (slight/none = sharper).
-- Terminal Neovim: set font in your terminal (e.g. iTerm → Profiles → Text → Font).
vim.opt.guifont = "FiraMono Nerd Font Mono:h12:#e-subpixelantialias:#h-slight"
vim.opt.linespace = 0               -- Tighter line spacing (increase if text feels cramped)
-- Neovide: sharper text (no effect in terminal/other GUIs)
vim.g.neovide_scale_factor = 1.0
vim.g.neovide_refresh_rate = 60
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_no_idle = false      -- false = better battery; true = slightly smoother
vim.opt.number = true               -- Show line numbers
vim.opt.relativenumber = true       -- Show relative line numbers (better for navigation)
vim.opt.cursorline = true           -- Highlight the current line
vim.opt.cursorlineopt = "number"    -- Only highlight line number (faster on large files)
vim.opt.showmode = false            -- Hide mode indicator (handled by statusline)
vim.opt.signcolumn = "yes"          -- Always show sign column (for diagnostics)
vim.opt.colorcolumn = "80"          -- Highlight column 80 (line length guide)
vim.opt.scrolloff = 8               -- Keep 8 lines above/below cursor when scrolling
vim.opt.sidescrolloff = 8           -- Keep 8 columns left/right of cursor when scrolling

-- =============================================================================
-- WINDOW SPLITTING
-- =============================================================================
vim.opt.splitbelow = true           -- Open horizontal splits below current window
vim.opt.splitright = true           -- Open vertical splits to the right of current window

-- =============================================================================
-- SEARCH & REPLACE
-- =============================================================================
vim.opt.incsearch = true            -- Show search matches as you type
vim.opt.hlsearch = false            -- Don't highlight search matches by default
vim.opt.ignorecase = true           -- Ignore case in searches
vim.opt.smartcase = true            -- Override ignorecase if search contains uppercase

-- =============================================================================
-- TEXT WRAPPING
-- =============================================================================
vim.opt.wrap = false                -- Don't wrap long lines
vim.opt.linebreak = true            -- Break lines at word boundaries when wrapping
vim.opt.breakindent = true          -- Maintain indent when wrapping

-- =============================================================================
-- PERFORMANCE & BEHAVIOR
-- =============================================================================
vim.opt.updatetime = 200            -- CursorHold, swapfile, etc. (lower = snappier, more CPU)
vim.opt.timeoutlen = 300            -- Time to wait for a mapped sequence to complete
vim.opt.ttimeoutlen = 10            -- Time to wait for key codes to complete

-- =============================================================================
-- BACKUP & UNDO
-- =============================================================================
vim.opt.backup = false              -- Don't create backup files
vim.opt.writebackup = false         -- Don't create backup files while editing
vim.opt.undofile = true             -- Enable persistent undo
vim.opt.undolevels = 1000           -- Maximum number of changes that can be undone

-- =============================================================================
-- FOLDING
-- =============================================================================
vim.opt.foldmethod = "expr"         -- Use expression for folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Use treesitter for folding
vim.opt.foldlevel = 99              -- Don't fold by default
vim.opt.foldlevelstart = 99         -- Don't fold when opening files

-- =============================================================================
-- LARGE FILE: disable relativenumber (faster scrolling)
-- =============================================================================
local large_file_line_limit = 10000
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("LargeFileRelativenumber", { clear = true }),
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    vim.wo.relativenumber = line_count <= large_file_line_limit
  end,
})

