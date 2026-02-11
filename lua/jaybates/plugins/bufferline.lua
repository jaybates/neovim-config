return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "buffers", -- Show open buffers (files); click or use Shift+h/l to switch
      -- Flat, classic CLI look (no tab-like slant)
      separator_style = "none",
      indicator = { style = "none" },
      padding = 0,
      tab_size = 0,
      max_name_length = 18,
      max_prefix_length = 15,
      show_buffer_close_icons = true,
      show_close_icon = true,
      -- Don't show Nvim-tree or other special buffers as tabs
      excluded_filetypes = { "NvimTree", "nvim-tree", "TelescopePrompt", "noice", "lazy", "prompt" },
      excluded_buftypes = { "nofile", "terminal", "prompt" },
      -- Offset tabline right so it aligns with editor (not over nvim-tree); padding = 1 for split separator
      offsets = {
        { filetype = "NvimTree", padding = 1 },
      },
      -- Close only the buffer that was clicked (no auto-close of "blank" to avoid doubling/race)
      close_command = function(bufnum)
        vim.cmd("bdelete " .. bufnum)
      end,
    },
    highlights = {
      fill = { bg = "NONE" },
      background = { bg = "NONE" },
      buffer_visible = { bg = "NONE" },
      buffer_selected = { bold = true },
      separator = { fg = "NONE", bg = "NONE" },
      separator_visible = { fg = "NONE", bg = "NONE" },
      separator_selected = { fg = "NONE", bg = "NONE" },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Tabline is always shown; options.offsets shifts buffer names right of nvim-tree
  end,
}