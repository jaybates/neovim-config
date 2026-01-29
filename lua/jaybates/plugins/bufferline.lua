return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "buffers", -- Show open buffers (files); click or use Shift+h/l to switch
      separator_style = "slant",
      -- Don't show Nvim-tree or other special buffers as tabs
      excluded_filetypes = { "NvimTree", "nvim-tree", "TelescopePrompt", "noice", "lazy", "prompt" },
      excluded_buftypes = { "nofile", "terminal", "prompt" },
      -- Close only the buffer that was clicked (no auto-close of "blank" to avoid doubling/race)
      close_command = function(bufnum)
        vim.cmd("bdelete " .. bufnum)
      end,
    },
  },
}