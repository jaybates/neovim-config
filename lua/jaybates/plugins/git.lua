-- =============================================================================
-- Git Integration Configuration
-- =============================================================================
-- Comprehensive Git support for Neovim
-- Includes Git signs, blame, diff, and other Git operations

return {
  -- =============================================================================
  -- GIT SIGNS
  -- =============================================================================
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Next hunk" })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Previous hunk" })

          -- Actions
          map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
          map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
          map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
          map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
          map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, { desc = "Blame line" })
          map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle blame" })
          map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
          map("n", "<leader>hD", function()
            gs.diffthis("~")
          end, { desc = "Diff this ~" })
          map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
        end,
      })
    end,
  },

  -- =============================================================================
  -- GIT DIFFVIEW
  -- =============================================================================
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local diffview = require("diffview")
      diffview.setup({
        diff_binaries = false,
        enhanced_diff_hl = false,
        git_cmd = { "git" },
        use_icons = true,
        show_help_hints = true,
        watch_index = true,
        icons = {
          folder_closed = "📁",
          folder_open = "📂",
        },
        signs = {
          fold_closed = "▶",
          fold_open = "▼",
          done = "✓",
        },
        view = {
          default = {
            layout = "diff2_horizontal",
            winbar_info = false,
          },
          merge_tool = {
            layout = "diff3_horizontal",
            disable_diagnostics = true,
            winbar_info = true,
          },
          file_history = {
            layout = "diff2_horizontal",
            winbar_info = false,
          },
        },
        file_panel = {
          listing_style = "tree",
          tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded",
          },
          win_config = {
            position = "left",
            width = 35,
            win_opts = {},
          },
        },
        file_history_panel = {
          log_options = {
            git = {
              single_file = {
                diff_merges = "combined",
              },
              multi_file = {
                diff_merges = "first-parent",
              },
            },
          },
          win_config = {
            position = "bottom",
            height = 16,
            win_opts = {},
          },
        },
        commit_log_panel = {
          win_config = {
            win_opts = {},
          },
        },
        default_args = {
          DiffviewOpen = {},
          DiffviewFileHistory = {},
        },
        hooks = {},
      })

      -- Key mappings
      vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Open diff view" })
      vim.keymap.set("n", "<leader>gD", ":DiffviewClose<CR>", { desc = "Close diff view" })
      vim.keymap.set("n", "<leader>gf", ":DiffviewFileHistory<CR>", { desc = "File history" })
    end,
  },

  -- =============================================================================
  -- GIT CONFLICT RESOLUTION
  -- =============================================================================
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("git-conflict").setup({
        default_mappings = true,
        default_commands = true,
        disable_diagnostics = false,
        list_opener = "copen",
        debug = false,
      })

      -- Key mappings
      vim.keymap.set("n", "<leader>gco", ":GitConflictChooseOurs<CR>", { desc = "Choose ours" })
      vim.keymap.set("n", "<leader>gct", ":GitConflictChooseTheirs<CR>", { desc = "Choose theirs" })
      vim.keymap.set("n", "<leader>gcb", ":GitConflictChooseBoth<CR>", { desc = "Choose both" })
      vim.keymap.set("n", "<leader>gc0", ":GitConflictChooseNone<CR>", { desc = "Choose none" })
      vim.keymap.set("n", "<leader>gcn", ":GitConflictNextConflict<CR>", { desc = "Next conflict" })
      vim.keymap.set("n", "<leader>gcp", ":GitConflictPrevConflict<CR>", { desc = "Previous conflict" })
    end,
  },

  -- =============================================================================
  -- GIT WORKTREE
  -- =============================================================================
  {
    "ThePrimeagen/git-worktree.nvim",
    event = "VeryLazy",
    config = function()
      require("git-worktree").setup({
        change_directory_command = "cd",
        update_on_change = true,
        update_on_change_command = "e .",
        clearjumps_on_cwd_change = true,
        autopush = false,
      })

      -- Key mappings
      vim.keymap.set("n", "<leader>gwt", ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", { desc = "Git worktrees" })
      vim.keymap.set("n", "<leader>gwc", ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", { desc = "Create worktree" })
    end,
  },

  -- =============================================================================
  -- GIT MESSAGES
  -- =============================================================================
  {
    "rhysd/git-messenger.vim",
    event = "VeryLazy",
    config = function()
      vim.g.git_messenger_no_default_mappings = true
      vim.g.git_messenger_always_into_popup = true
      vim.g.git_messenger_floating_win_opts = { border = "rounded" }

      -- Key mappings
      vim.keymap.set("n", "<leader>gm", ":GitMessenger<CR>", { desc = "Git messenger" })
    end,
  },
}
