# Plugin Recommendations & Optimizations

## 🚀 Recommended Additional Plugins

### Essential Productivity Plugins

#### 1. **nvim-dap** - Debug Adapter Protocol
```lua
-- Add to plugins/debugging.lua
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    -- DAP configuration
  end,
}
```

#### 2. **gitsigns.nvim** - Git Integration
```lua
-- Add to plugins/git.lua
return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
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
    })
  end,
}
```

#### 3. **nvim-ufo** - Better Folding
```lua
-- Add to plugins/folding.lua
return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  config = function()
    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    })
  end,
}
```

#### 4. **mini.ai** - Enhanced Text Objects
```lua
-- Add to plugins/mini.lua
return {
  "echasnovski/mini.ai",
  event = "VeryLazy",
  config = function()
    require("mini.ai").setup()
  end,
}
```

#### 5. **flash.nvim** - Enhanced Motion
```lua
-- Add to plugins/motion.lua
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  config = function()
    require("flash").setup()
  end,
}
```

### Language-Specific Plugins

#### 6. **nvim-ts-context-commentstring** - Context-Aware Comments
```lua
-- Already included but ensure proper setup
return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  event = "VeryLazy",
  config = function()
    require("ts_context_commentstring").setup({
      enable_autocmd = false,
    })
  end,
}
```

#### 7. **nvim-autopairs** - Auto-pairing (Enhanced)
```lua
-- Your current setup is good, but consider these additions:
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = { "hrsh7th/nvim-cmp" },
  config = function()
    local autopairs = require("nvim-autopairs")
    autopairs.setup({
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    })
  end,
}
```

### UI Enhancement Plugins

#### 8. **nvim-scrollbar** - Scrollbar with Diagnostics
```lua
-- Add to plugins/ui.lua
return {
  "petertriho/nvim-scrollbar",
  event = "VeryLazy",
  config = function()
    require("scrollbar").setup({
      show = true,
      show_in_active_only = false,
      set_highlights = true,
      folds = 1000,
      max_lines = false,
      hide_if_all_visible = false,
      throttle_ms = 100,
      handle = {
        text = " ",
        blend = 50,
        color = nil,
        color_nr = nil,
        highlight = "CursorColumn",
        hide_if_all_visible = true,
      },
      marks = {
        Cursor = {
          text = " ",
          priority = 0,
          gui = nil,
          line = true,
          threshold = nil,
        },
        Search = {
          text = { "-", "=" },
          priority = 1,
          gui = nil,
          line = true,
          threshold = 999,
        },
        Error = {
          text = { "-", "=" },
          priority = 2,
          gui = nil,
          line = true,
          threshold = 999,
        },
        Warn = {
          text = { "-", "=" },
          priority = 3,
          gui = nil,
          line = true,
          threshold = 999,
        },
        Info = {
          text = { "-", "=" },
          priority = 4,
          gui = nil,
          line = true,
          threshold = 999,
        },
        Hint = {
          text = { "-", "=" },
          priority = 5,
          gui = nil,
          line = true,
          threshold = 999,
        },
        Misc = {
          text = { "-", "=" },
          priority = 6,
          gui = nil,
          line = true,
          threshold = 999,
        },
      },
      excluded_buftypes = { "terminal" },
      excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "lazy" },
      autocmd = {
        render = {
          "BufWinEnter",
          "TabEnter",
          "TermEnter",
          "WinEnter",
          "CmdwinLeave",
          "TextChanged",
          "VimResized",
          "WinScrolled",
        },
        clear = {
          "BufWinLeave",
          "TabLeave",
          "TermLeave",
          "WinLeave",
        },
      },
      handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = false,
        search = false,
        ale = false,
      },
    })
  end,
}
```

#### 9. **nvim-web-devicons** - Better Icons
```lua
-- Already included, but ensure proper setup
return {
  "nvim-tree/nvim-web-devicons",
  lazy = true,
  config = function()
    require("nvim-web-devicons").setup({
      override = {},
      default = true,
    })
  end,
}
```

## 🔧 Configuration Optimizations

### 1. **Lazy Loading Optimization**
```lua
-- In lazy.lua, add these optimizations:
require("lazy").setup({
  { import = "jaybates.plugins" }
}, {
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "rounded",
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📋",
      lazy = "💤 ",
    },
  },
})
```

### 2. **Telescope Optimizations**
```lua
-- Add to telescope.lua
telescope.setup({
  defaults = {
    -- Use fd for better performance
    find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
    -- Better sorting
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    -- Better preview
    preview = {
      treesitter = {
        disable = { "html", "css", "scss", "sass", "less", "json", "yaml", "toml" }
      }
    },
  },
})
```

### 3. **LSP Optimizations**
```lua
-- Add to nvim-lspconfig.lua
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" }
}

-- Use capabilities in all LSP setups
```

### 4. **Treesitter Optimizations**
```lua
-- Add to treesitter.lua
treesitter.setup({
  -- Better performance
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = { "latex" }, -- Disable for large files
  },
  -- Better folding
  fold = {
    enable = true,
    disable = { "markdown" }, -- Disable for markdown
  },
})
```

## 🎯 Performance Tips

### 1. **Startup Time Optimization**
- Use `lazy = true` for non-essential plugins
- Load plugins on specific events when possible
- Disable unused Neovim plugins

### 2. **Memory Usage**
- Use `lazy = true` for large plugins
- Avoid loading plugins in `init.lua`
- Use `event = "VeryLazy"` for non-critical plugins

### 3. **CPU Usage**
- Use native extensions (fzf-native)
- Enable caching where possible
- Use efficient file finders (fd, ripgrep)

## 📊 Plugin Categories

### Essential (Must Have)
- lazy.nvim (plugin manager)
- nvim-cmp (completion)
- telescope.nvim (fuzzy finder)
- treesitter (syntax highlighting)
- mason.nvim (LSP installer)
- nvim-lspconfig (LSP configuration)

### Highly Recommended
- gitsigns.nvim (git integration)
- nvim-dap (debugging)
- nvim-ufo (folding)
- mini.ai (text objects)
- flash.nvim (motion)

### Nice to Have
- nvim-scrollbar (scrollbar)
- nvim-autopairs (auto-pairing)
- nvim-surround (surround text)
- comment.nvim (commenting)
- todo-comments.nvim (todo highlighting)

### Optional
- alpha-nvim (startup screen)
- bufferline.nvim (buffer line)
- lualine.nvim (status line)
- which-key.nvim (key helper)
- trouble.nvim (diagnostics)

## 🔄 Migration Guide

### From vim-plug to lazy.nvim
1. Remove vim-plug configuration
2. Convert plugin syntax to lazy.nvim format
3. Add proper lazy loading conditions
4. Test each plugin individually

### From packer.nvim to lazy.nvim
1. Convert `use` statements to return tables
2. Move configurations to `config` functions
3. Add proper dependencies
4. Test plugin loading

## 🐛 Common Issues & Solutions

### Issue: Slow startup
**Solution**: Use lazy loading and disable unused plugins

### Issue: High memory usage
**Solution**: Use `lazy = true` and proper event triggers

### Issue: LSP not working
**Solution**: Check Mason installation and server setup

### Issue: Completion not working
**Solution**: Verify nvim-cmp sources and LSP setup

### Issue: Telescope slow
**Solution**: Use fd and ripgrep, enable fzf-native

## 📚 Additional Resources

- [Neovim Configuration Guide](https://neovim.io/doc/user/)
- [Lazy.nvim Documentation](https://github.com/folke/lazy.nvim)
- [LSP Configuration Guide](https://github.com/neovim/nvim-lspconfig)
- [Treesitter Documentation](https://github.com/nvim-treesitter/nvim-treesitter)
- [Telescope Documentation](https://github.com/nvim-telescope/telescope.nvim)
