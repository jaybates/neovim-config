# Neovim Configuration

A modern, well-organized Neovim configuration built with Lua and lazy.nvim.

## 🚀 Features

- **Modern Plugin Manager**: Uses lazy.nvim for fast, lazy-loaded plugins
- **Language Server Protocol**: Full LSP support with Mason for server management
- **Intelligent Completion**: nvim-cmp with multiple sources and snippets
- **Fuzzy Finding**: Telescope for file, buffer, and content searching
- **Syntax Highlighting**: Treesitter with advanced text objects
- **Git Integration**: Git signs, blame, and diff highlighting with LazyGit
- **Terminal Integration**: Multiple terminal types with ToggleTerm and Floaterm
- **Beautiful UI**: Catppuccin colorscheme with custom statusline
- **Code Formatting**: Automatic formatting with conform.nvim
- **Linting**: Real-time linting with nvim-lint
- **File Explorer**: Nvim-tree for file navigation
- **Debugging**: DAP integration for debugging
- **Snippets**: LuaSnip with friendly-snippets
- **AI Integration**: Claude AI for code assistance and generation

## 📁 Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lazy-lock.json          # Plugin lock file
└── lua/
    └── jaybates/
        ├── init.lua        # Configuration loader
        ├── lazy.lua        # Lazy.nvim setup
        └── core/
            ├── init.lua    # Core configuration loader
            ├── options.lua # Neovim options
            ├── keyremaps.lua # Basic key mappings
            └── keymaps.lua # Advanced plugin key mappings
        └── plugins/
            ├── init.lua    # Plugin dependencies
            ├── alpha.lua   # Startup screen
            ├── autopairs.lua # Auto-pairing brackets
            ├── bufferline.lua # Buffer line
            ├── colorscheme.lua # Catppuccin theme
            ├── comment.lua # Commenting
            ├── conform.lua # Code formatting
            ├── dressing.lua # Enhanced UI
            ├── harpoon.lua # File marks
            ├── indent-blankline.lua # Indent guides
            ├── lualine.lua # Status line
            ├── noice.lua   # Enhanced UI
            ├── nvim-cmp.lua # Completion engine
            ├── nvim-lint.lua # Linting
            ├── nvim-notify.lua # Notifications
            ├── nvim-surround.lua # Surround text
            ├── nvim-tree.lua # File explorer
            ├── nvim-treesitter-text-objects.lua # Text objects
            ├── substitute.lua # Text substitution
            ├── telescope.lua # Fuzzy finder
            ├── todo-comments.lua # Todo highlighting
            ├── treesitter.lua # Syntax highlighting
            ├── trouble.lua # Diagnostics
            ├── which-key.lua # Key mapping helper
            └── lsp/
                ├── mason.lua # LSP installer
                └── nvim-lspconfig.lua # LSP configuration
```

## 🔧 Installation

1. **Install Neovim** (0.9+ required):
   ```bash
   # macOS
   brew install neovim
   
   # Ubuntu/Debian
   sudo apt install neovim
   
   # Arch Linux
   sudo pacman -S neovim
   ```

2. **Clone this configuration**:
   ```bash
   git clone <your-repo> ~/.config/nvim
   cd ~/.config/nvim
   ```

3. **Install dependencies**:
   ```bash
   # Install Node.js (for LSP servers)
   curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
   sudo apt-get install -y nodejs
   
   # Install fd (for telescope)
   sudo apt install fd-find
   
   # Install ripgrep (for telescope)
   sudo apt install ripgrep
   ```

4. **Start Neovim**:
   ```bash
   nvim
   ```

   Lazy.nvim will automatically install all plugins on first run.

## ⌨️ Key Mappings

### Leader Key
- `<Space>` - Leader key

### File Operations
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fh` - Find help tags
- `<leader>fr` - Find recent files
- `<leader>fc` - Find string under cursor

### File Explorer
- `<leader>ee` - Toggle file explorer
- `<leader>ef` - Find file in explorer
- `<leader>ec` - Collapse explorer
- `<leader>er` - Refresh explorer

### LSP Operations
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `K` - Show documentation
- `<leader>d` - Show line diagnostics
- `<leader>D` - Show buffer diagnostics
- `]d` - Next diagnostic
- `[d` - Previous diagnostic

### Git Operations
- `<leader>gs` - Git status
- `<leader>gb` - Git branches
- `<leader>gc` - Git commits

### Buffer Management
- `<S-h>` - Previous buffer
- `<S-l>` - Next buffer
- `<leader>bd` - Delete buffer
- `<leader>ba` - Delete all buffers

### Window Management
- `<C-h/j/k/l>` - Navigate windows
- `<C-Up/Down/Left/Right>` - Resize windows
- `<A-j/k>` - Move lines up/down

### Commenting
- `<leader>/` - Toggle comment

### Formatting
- `<leader>mp` - Format file/selection

### Harpoon (File Marks)
- `<leader>ha` - Add file to harpoon
- `<leader>hh` - Toggle harpoon menu
- `<leader>h1/2/3/4` - Navigate to marked files

### Terminal Operations
- `<leader>tt` - Toggle terminal
- `<leader>tf` - Toggle floating terminal
- `<leader>th` - Toggle horizontal terminal
- `<leader>tv` - Toggle vertical terminal
- `<leader>tT` - Toggle tab terminal
- `<leader>t1/2/3/4` - Toggle numbered terminals
- `<leader>tg` - Open LazyGit
- `<leader>tn` - Node.js REPL
- `<leader>tp` - Python REPL

### Trouble (Diagnostics)
- `<leader>xx` - Toggle trouble
- `<leader>xw` - Workspace diagnostics
- `<leader>xd` - Document diagnostics
- `<leader>xq` - Quickfix list
- `<leader>xl` - Location list
- `<leader>xt` - Todo trouble

## 🎨 Customization

### Colorscheme
The configuration uses Catppuccin with the Macchiato variant. To change:

1. Edit `lua/jaybates/plugins/colorscheme.lua`
2. Change the `flavour` option:
   ```lua
   flavour = "latte", -- or "frappe", "macchiato", "mocha"
   ```

### Adding Plugins
1. Create a new file in `lua/jaybates/plugins/`
2. Follow the existing plugin structure
3. Add key mappings to `lua/jaybates/core/keymaps.lua` if needed

### LSP Servers
To add new LSP servers:

1. Edit `lua/jaybates/plugins/lsp/mason.lua`
2. Add the server to `ensure_installed`:
   ```lua
   ensure_installed = {
     "your_lsp_server",
     -- ... other servers
   }
   ```

### Formatters
To add new formatters:

1. Edit `lua/jaybates/plugins/conform.lua`
2. Add the formatter to `formatters_by_ft`:
   ```lua
   formatters_by_ft = {
     your_filetype = { "your_formatter" },
     -- ... other formatters
   }
   ```

## 🔍 Troubleshooting

### Common Issues

1. **Plugins not loading**: Run `:Lazy sync` to sync plugins
2. **LSP not working**: Run `:Mason` to check server installation
3. **Treesitter errors**: Run `:TSUpdate` to update parsers
4. **Performance issues**: Check `:Lazy profile` for slow plugins

### Debug Mode
Enable debug mode by setting `debug = true` in `lua/jaybates/lazy.lua`

### Logs
- Lazy.nvim logs: `~/.local/state/nvim/lazy.log`
- Neovim logs: `:messages`

## 📚 Plugin Documentation

- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [lspconfig](https://github.com/neovim/nvim-lspconfig)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This configuration is provided as-is for educational and personal use.

## 🙏 Acknowledgments

- [LazyVim](https://github.com/LazyVim/LazyVim) for inspiration
- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) for structure
- All the amazing Neovim plugin developers
# neovim-config
