# Terminal Integration Guide

## Overview
Your Neovim configuration now includes comprehensive terminal integration that provides a powerful CLI experience directly within the editor. This includes multiple terminal types, specialized terminals, and enhanced command-line tools.

## 🚀 Features

### **Multiple Terminal Types**
- **Floating Terminal**: Overlay terminal that appears on top of your editor
- **Horizontal Terminal**: Terminal split at the bottom of the screen
- **Vertical Terminal**: Terminal split on the right side of the screen
- **Tab Terminal**: Terminal in its own tab
- **Multiple Terminals**: Up to 4 numbered terminals for different tasks

### **Specialized Terminals**
- **Git Terminal**: Dedicated terminal for Git operations
- **LazyGit Integration**: Beautiful Git interface with `lazygit`
- **Node.js REPL**: Interactive JavaScript/TypeScript REPL
- **Python REPL**: Interactive Python REPL
- **Task Runner**: Built-in task execution with `overseer.nvim`

### **Enhanced CLI Tools**
- **LazyGit**: Modern Git interface with visual diff and staging
- **htop**: System monitoring and process management
- **tree**: Directory structure visualization
- **bat**: Syntax-highlighted file viewing
- **eza**: Enhanced `ls` command with better formatting (replacement for exa)

## ⌨️ Key Mappings

### **Basic Terminal Operations**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>tt` | Toggle Terminal | Open/close default terminal |
| `<leader>tf` | Floating Terminal | Open floating terminal |
| `<leader>th` | Horizontal Terminal | Open horizontal split terminal |
| `<leader>tv` | Vertical Terminal | Open vertical split terminal |
| `<leader>tT` | Tab Terminal | Open terminal in new tab |

### **Multiple Terminals**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>t1` | Terminal 1 | Toggle terminal 1 |
| `<leader>t2` | Terminal 2 | Toggle terminal 2 |
| `<leader>t3` | Terminal 3 | Toggle terminal 3 |
| `<leader>t4` | Terminal 4 | Toggle terminal 4 |

### **Specialized Terminals**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>tg` | LazyGit | Open Git interface |
| `<leader>tn` | Node REPL | Open Node.js REPL |
| `<leader>tp` | Python REPL | Open Python REPL |

### **Terminal Navigation**
| Key | Action | Description |
|-----|--------|-------------|
| `<C-\>` | Toggle Terminal | Open/close terminal (in terminal mode) |
| `<Esc><Esc>` | Exit Terminal Mode | Return to normal mode |
| `<C-h/j/k/l>` | Window Navigation | Move between windows from terminal |
| `<C-w>` | Window Commands | Access window commands from terminal |
| `<C-q>` | Quit | Close current window from terminal |

### **Floaterm Integration**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ft` | Toggle Floaterm | Toggle floaterm terminal |
| `<leader>fn` | New Floaterm | Create new floaterm |
| `<leader>fk` | Kill Floaterm | Close current floaterm |
| `<leader>fp` | Previous Floaterm | Switch to previous floaterm |
| `<leader>fn` | Next Floaterm | Switch to next floaterm |
| `<leader>fs` | Show Floaterm | Show hidden floaterm |
| `<leader>fh` | Hide Floaterm | Hide current floaterm |

### **Task Runner (Overseer)**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>or` | Run Task | Execute a task |
| `<leader>ot` | Toggle Overseer | Show/hide task runner |
| `<leader>oq` | Quick Action | Quick task action |
| `<leader>oc` | Close Overseer | Close task runner |

## 🛠️ Commands

### **Terminal Commands**
```vim
:Terminal                    " Open default terminal
:Terminal float              " Open floating terminal
:Terminal horizontal         " Open horizontal terminal
:Terminal vertical           " Open vertical terminal
:Terminal tab                " Open tab terminal
:TerminalNew [type]          " Create new terminal of specified type
```

### **LazyGit Commands**
```vim
:LazyGit                     " Open LazyGit
:LazyGitCurrentFile          " Open LazyGit for current file
:LazyGitFilter               " Open LazyGit with filter
:LazyGitConfig               " Open LazyGit configuration
```

### **Task Runner Commands**
```vim
:OverseerRun                 " Run a task
:OverseerToggle              " Toggle task runner
:OverseerQuickAction         " Quick task action
:OverseerClose               " Close task runner
```

## 🔧 Configuration

### **Terminal Settings**
- **Default Direction**: Float (overlay)
- **Size**: 80% of screen for floating, 15 lines for horizontal, 40% width for vertical
- **Border**: Curved border for floating terminals
- **Auto-scroll**: Automatically scroll to bottom on output
- **Close on Exit**: Terminal closes when process exits

### **Floaterm Settings**
- **Window Type**: Floating
- **Position**: Center of screen
- **Size**: 80% of screen dimensions
- **Border**: Rounded corners
- **Auto-close**: Close on successful exit
- **Auto-hide**: Hide when switching to other windows

### **LazyGit Integration**
- **Auto-open**: Opens in floating terminal
- **Key Bindings**: Integrated with Neovim key mappings
- **Current File**: Can open LazyGit for specific files
- **Filtering**: Support for file filtering

## 📦 Dependencies

The terminal integration automatically installs these CLI tools:

### **Core Tools**
- `lazygit` - Modern Git interface
- `htop` - System monitoring
- `tree` - Directory visualization
- `bat` - Syntax-highlighted file viewing
- `eza` - Enhanced ls command (replacement for exa)

### **System Requirements**
- `node` - For JavaScript/TypeScript REPL
- `python3` - For Python REPL
- `curl` - For HTTP requests
- `jq` - For JSON parsing

## 🎯 Use Cases

### **Development Workflow**
1. **Code Editing**: Use normal Neovim for editing
2. **Terminal Access**: Press `<leader>tt` for quick terminal access
3. **Git Operations**: Press `<leader>tg` for LazyGit interface
4. **Testing**: Use `<leader>tn` or `<leader>tp` for REPL testing
5. **Task Running**: Use `<leader>or` for running build/test tasks

### **File Management**
1. **Directory Browsing**: Use `tree` command in terminal
2. **File Viewing**: Use `bat` for syntax-highlighted file viewing
3. **System Monitoring**: Use `htop` for process monitoring
4. **Enhanced Listing**: Use `eza` for better file listings

### **Git Workflow**
1. **Quick Git**: Press `<leader>tg` for LazyGit
2. **Current File**: Use `:LazyGitCurrentFile` for file-specific Git
3. **Filtering**: Use `:LazyGitFilter` for filtered Git operations
4. **Configuration**: Use `:LazyGitConfig` to modify settings

## 🔄 Integration with Other Plugins

### **Telescope Integration**
- Terminal output can be searched with Telescope
- File paths in terminal can be opened with Telescope
- Terminal history is searchable

### **LSP Integration**
- Python terminal auto-opens when Python LSP is attached
- Node terminal auto-opens when TypeScript LSP is attached
- Terminal respects LSP diagnostics and suggestions

### **Git Integration**
- LazyGit integrates with Git signs
- Terminal shows Git status in prompt
- Git operations are tracked in terminal history

## 🚨 Troubleshooting

### **Common Issues**

**Terminal not opening**
- Check if `toggleterm.nvim` is installed: `:checkhealth toggleterm`
- Verify terminal key mappings: `:map <leader>tt`

**LazyGit not working**
- Install lazygit: `brew install lazygit` (macOS) or `sudo apt install lazygit` (Linux)
- Check if lazygit is in PATH: `which lazygit`

**Terminal navigation issues**
- Ensure terminal mode mappings are loaded
- Check if `<C-\>` is not conflicting with other mappings

**Floaterm not appearing**
- Check if `vim-floaterm` is installed
- Verify floaterm settings: `:FloatermConfig`

### **Performance Tips**

1. **Limit Terminal Count**: Don't open too many terminals simultaneously
2. **Use Appropriate Types**: Use floating for quick tasks, splits for long-running processes
3. **Close Unused Terminals**: Close terminals when not needed
4. **Monitor Resources**: Use `htop` to monitor system resources

## 🎨 Customization

### **Terminal Appearance**
```lua
-- In your config, you can customize:
vim.g.floaterm_borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8
```

### **Key Mappings**
```lua
-- Add custom terminal key mappings:
vim.keymap.set("n", "<leader>myterm", "<cmd>ToggleTerm<cr>", { desc = "My custom terminal" })
```

### **Terminal Commands**
```lua
-- Create custom terminal commands:
vim.api.nvim_create_user_command("MyTerminal", function()
    -- Custom terminal logic
end, { desc = "My custom terminal command" })
```

This terminal integration provides a complete CLI experience within Neovim, making it a powerful development environment! 🚀
