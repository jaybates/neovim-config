# Neovim Configuration

A modern, IDE-style Neovim configuration built with Lua and lazy.nvim. Tuned for React/JS, Node, Python, Go, PHP, GraphQL, and common config formats (JSON, YAML, XML, SQL, Docker, Terraform).

## 🚀 Features

- **Modern Plugin Manager**: lazy.nvim for fast, lazy-loaded plugins
- **Language Server Protocol**: Full LSP support with Mason and mason-lspconfig
- **Intelligent Completion**: nvim-cmp with LSP, snippets, buffer, and path sources
- **Fuzzy Finding**: Telescope (horizontal layout, fd/ripgrep) for files, buffers, and grep
- **Syntax Highlighting**: Treesitter with text objects and incremental selection
- **Git**: Gitsigns, Diffview, LazyGit (`<leader>gg`), conflict resolution, worktrees
- **Terminal**: ToggleTerm (floating/horizontal/vertical, numbered); LazyGit via lazygit.nvim
- **UI**: Catppuccin colorscheme, Lualine, Bufferline (buffers, not tabs), Nvim-tree, Dressing, Noice
- **Formatting & Linting**: Conform (format-on-save optional) and nvim-lint (debounced)
- **File Explorer**: Nvim-tree (stays open; placeholder layout when opening a directory)
- **Debugging**: DAP integration (debugging.lua)
- **Sessions & Projects**: Session manager and project.nvim (Telescope projects)
- **AI**: Claude plugin for code assistance

## 📁 Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lazy-lock.json              # Plugin lock file
├── validate_config.lua         # Optional config validator
└── lua/jaybates/
    ├── init.lua                # Loads core and lazy
    ├── lazy.lua                # Lazy.nvim setup (load order documented)
    └── core/
        ├── init.lua            # Options, keyremaps, keymaps; LSP shim; project layout
        ├── options.lua         # Neovim options (GUI, relativenumber, large-file)
        ├── keyremaps.lua       # Basic keymaps (buffer/window/terminal/search)
        ├── keymaps.lua         # Plugin keymaps (Telescope, LSP, format, comment, etc.)
        └── dependency_installer.lua  # Auto-install fd, ripgrep, etc.
    └── plugins/
        ├── init.lua            # Plenary (priority 1000)
        ├── alpha.lua           # Startup dashboard (custom NEOVIM header)
        ├── autopairs.lua       # Auto-pairing
        ├── bufferline.lua      # Buffer line (buffers, not tabs)
        ├── colorscheme.lua     # Catppuccin
        ├── comment.lua         # Comment.nvim
        ├── conform.lua         # Formatting (LSP fallback)
        ├── debugging.lua      # DAP
        ├── dressing.lua        # UI (inputs, selects)
        ├── harpoon.lua         # File marks
        ├── indent-blankline.lua # Indent guides
        ├── lualine.lua         # Statusline
        ├── noice.lua           # Cmdline/notify UI
        ├── nvim-cmp.lua        # Completion
        ├── nvim-lint.lua       # Linting (debounced)
        ├── nvim-notify.lua     # Notifications
        ├── nvim-surround.lua   # Surround
        ├── nvim-tree.lua       # File explorer
        ├── nvim-treesitter-text-objects.lua # Text objects
        ├── projects.lua        # project.nvim (Telescope projects)
        ├── sessions.lua        # Session manager
        ├── substitute.lua      # Substitute.nvim
        ├── telescope.lua       # Fuzzy finder (horizontal layout)
        ├── terminal.lua        # ToggleTerm
        ├── terminal-extras.lua # LazyGit (<leader>gg), Overseer
        ├── todo-comments.lua   # TODO/FIXME
        ├── treesitter.lua      # Treesitter
        ├── trouble.lua         # Diagnostics/quickfix UI
        ├── web-dev.lua         # Emmet, autotag
        ├── which-key.lua       # Keybinding hints
        ├── claude.lua          # Claude AI
        └── lsp/
            ├── mason.lua       # Mason + mason-tool-installer
            └── nvim-lspconfig.lua # LSP config + mason-lspconfig handlers
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

**Leader key:** `<Space>`. Press `<Space>` and wait for Which-key to see all bindings.

### File & navigation
- `<leader>ff` / `fg` / `fb` / `fr` / `fh` / `fc` – Find files, live grep, buffers, recent, help, word under cursor
- `<leader>gd` / `gr` / `gi` / `gt` – LSP definitions, references, implementations, type definitions
- `<leader>ds` / `ws` – Document symbols, workspace symbols
- `<leader>ee` / `ef` – Toggle Nvim-tree, Nvim-tree at current file
- `<leader>ec` / `er` – Collapse/refresh Nvim-tree
- `<leader>p` – Projects (Telescope)

### Buffer & window
- `<S-h>` / `<S-l>` – Previous/next buffer (or click bufferline)
- `<leader>bd` / `ba` – Close buffer / close all buffers
- `<C-h/j/k/l>` – Focus window left/down/up/right
- `<C-Up/Down/Left/Right>` – Resize window

### LSP & diagnostics
- `K` – Hover; `<leader>ca` – Code action; `<leader>rn` – Rename; `<leader>rs` – Restart LSP
- `<leader>d` / `D` – Line diagnostics float / buffer diagnostics (Telescope)
- `]d` / `[d` – Next/previous diagnostic
- `<leader>xx` / `xw` / `xd` / `xq` / `xl` / `xt` – Trouble (toggle, workspace, document, quickfix, loclist, todos)

### Git
- `<leader>gs` / `gb` / `gc` – Git status, branches, commits (Telescope)
- `<leader>gg` – LazyGit (lazygit.nvim)
- `<leader>gd` / `gD` / `gf` – Diffview open/close/file history (git.lua; may override LSP `gd` when both loaded)
- Gitsigns: `]c`/`[c` hunks, `<leader>hs`/`hr`/`hp`/`hb` stage/reset/preview/blame; `<leader>tb`/`td` toggle blame/deleted

### Edit & format
- `<leader>/` – Toggle comment; `<leader>mp` – Format (Conform + LSP fallback)
- `<A-j>` / `<A-k>` – Move line(s) down/up
- Substitute: `s`+motion, `ss`, `S`, `s` in visual

### Harpoon & terminal
- `<leader>ha` – Add to harpoon; `<leader>hh` – Menu; `<leader>h1`–`h4` – Jump to slot
- `<leader>tt` / `tf` / `th` / `tv` – Toggle terminal (default/float/horizontal/vertical)
- `<leader>t1`–`t4` – Numbered terminals; `<leader>tn` / `tp` – Node/Python REPL

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
LSP servers and handlers are in `lua/jaybates/plugins/lsp/nvim-lspconfig.lua` (mason-lspconfig `ensure_installed` and `handlers`). Mason itself is configured in `lua/jaybates/plugins/lsp/mason.lua`. Add new servers to the `ensure_installed` list in nvim-lspconfig.lua and add a handler if needed.

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
