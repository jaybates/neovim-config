return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = function()
          return math.floor(vim.o.columns * 0.15)
        end,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
          quit_on_open = false, -- Keep tree open when opening a file; close only via toggle
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    -- Ensure nvim-tree always has an open buffer beside it (never alone)
    local api = require("nvim-tree.api")
    local tree_width_pct = 0.15
    api.events.subscribe(api.events.Event.TreeOpen, function()
      vim.schedule(function()
        local wins = vim.api.nvim_list_wins()
        local has_other_buffer = false
        for _, w in ipairs(wins) do
          if vim.api.nvim_win_is_valid(w) then
            local b = vim.api.nvim_win_get_buf(w)
            local ft = vim.bo[b].filetype
            if ft ~= "NvimTree" and ft ~= "nvim-tree" then
              has_other_buffer = true
              break
            end
          end
        end
        if not has_other_buffer then
          vim.cmd("vsplit")
          vim.cmd("enew")
        end
        -- Resize tree to 15% after layout is ready (fixes 50/50 on startup)
        vim.defer_fn(function()
          local tree_width = math.floor(vim.o.columns * tree_width_pct)
          for _, w in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_is_valid(w) then
              local b = vim.api.nvim_win_get_buf(w)
              local ft = vim.bo[b].filetype
              if ft == "NvimTree" or ft == "nvim-tree" then
                vim.api.nvim_win_set_width(w, tree_width)
                break
              end
            end
          end
        end, 50)
      end)
    end)

    -- When the last window is closed with :q, close nvim-tree too (so :q and :bd behave the same)
    vim.api.nvim_create_autocmd("WinClosed", {
      group = vim.api.nvim_create_augroup("NvimTreeCloseOnLastWindow", { clear = true }),
      callback = function()
        vim.schedule(function()
          local wins = vim.api.nvim_list_wins()
          if #wins ~= 1 then return end
          local b = vim.api.nvim_win_get_buf(wins[1])
          local ft = vim.bo[b].filetype
          if ft == "NvimTree" or ft == "nvim-tree" then
            pcall(api.tree.close)
          end
        end)
      end,
    })

    -- When the last buffer is closed (e.g. :bd), close nvim-tree too
    vim.api.nvim_create_autocmd("BufWipeout", {
      group = vim.api.nvim_create_augroup("NvimTreeCloseOnLastBuffer", { clear = true }),
      callback = function(args)
        local wiped_buf = args.buf
        vim.schedule(function()
          local count = 0
          for _, b in ipairs(vim.api.nvim_list_bufs()) do
            if b == wiped_buf then goto continue end
            if vim.api.nvim_buf_is_valid(b)
                and vim.bo[b].buflisted
                and vim.bo[b].filetype ~= "NvimTree"
                and vim.bo[b].filetype ~= "nvim-tree" then
              count = count + 1
            end
            ::continue::
          end
          if count == 0 then
            pcall(api.tree.close)
          end
        end)
      end,
    })

    -- set keymaps (use Ctrl+h/j/k/l to move between nvim-tree and editor windows)
    local keymap = vim.keymap

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
  end
}