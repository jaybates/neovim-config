# Dependency Management System

## Overview
This Neovim configuration now includes an automated dependency management system that ensures all external dependencies are installed before plugins try to use them.

## Features

### 🔧 **Automatic Dependency Detection**
- Detects missing external dependencies on startup
- Supports multiple operating systems (macOS, Ubuntu, Debian, CentOS, RHEL, Arch)
- Provides helpful installation instructions for unsupported systems

### 📦 **Supported Dependencies**
- **curl**: For HTTP requests (Claude integration)
- **jq**: For JSON parsing (optional but helpful)
- **fd**: For fast file finding (Telescope)
- **ripgrep (rg)**: For fast text searching (Telescope)
- **fzf**: For fuzzy finding (Telescope fzf extension)
- **node**: For JavaScript/TypeScript LSP
- **python3**: For Python LSP
- **go**: For Go LSP
- **rustc**: For Rust LSP

### ⚡ **Smart Installation**
- **macOS**: Uses Homebrew (`brew install`)
- **Ubuntu/Debian**: Uses apt (`sudo apt install`)
- **CentOS/RHEL**: Uses yum (`sudo yum install`)
- **Arch**: Uses pacman (`sudo pacman -S`)

### 🎯 **User Commands**
- `:DependencyCheck` - Check which dependencies are missing
- `:DependencyInstall` - Install missing dependencies
- `:ClaudeInit` - Initialize Claude integration (if dependencies are ready)

## How It Works

### 1. **Startup Process**
```lua
-- On VimEnter, the system:
1. Detects the operating system
2. Checks for missing dependencies
3. Asks user permission to install
4. Installs dependencies if approved
5. Retries plugin initialization
```

### 2. **Plugin Integration**
```lua
-- Plugins check dependencies before initializing:
- Claude integration checks for plenary.nvim, nvim-notify, and API key
- Telescope checks for fd, ripgrep, fzf
- LSP plugins check for language-specific tools
```

### 3. **Graceful Fallbacks**
- If dependencies can't be installed automatically, provides manual instructions
- Creates user commands to retry installation
- Shows helpful error messages with next steps

## Configuration Files

### `lua/jaybates/core/dependency_installer.lua`
- Main dependency management module
- OS detection and package manager selection
- Installation logic and error handling

### `lua/jaybates/core/init.lua`
- Loads dependency installer on startup
- Sets up auto-installation with user confirmation

### `lua/jaybates/plugins/claude.lua`
- Example of plugin-specific dependency checking
- Graceful fallback to manual initialization

## Usage Examples

### Check Dependencies
```vim
:DependencyCheck
" Output: All external dependencies are installed!
" or: Missing dependencies: curl, jq
```

### Install Dependencies
```vim
:DependencyInstall
" Automatically installs missing dependencies
```

### Initialize Claude Integration
```vim
:ClaudeInit
" Initializes Claude if all dependencies are ready
```

## Benefits

### ✅ **Zero-Configuration Setup**
- New users can get started immediately
- Dependencies are installed automatically
- No manual setup required

### ✅ **Cross-Platform Support**
- Works on macOS, Linux distributions
- Provides instructions for unsupported systems
- Handles different package managers

### ✅ **Error Prevention**
- Prevents plugin errors due to missing dependencies
- Clear error messages with solutions
- Graceful degradation when dependencies are missing

### ✅ **Maintainable**
- Centralized dependency management
- Easy to add new dependencies
- Consistent error handling across plugins

## Adding New Dependencies

To add a new external dependency:

1. **Add to dependency list** in `dependency_installer.lua`:
```lua
local external_dependencies = {
    -- ... existing dependencies ...
    new_tool = "new-tool-command", -- Add your dependency
}
```

2. **Update package manager commands** if needed for specific systems

3. **Test on different operating systems** to ensure compatibility

## Troubleshooting

### Common Issues

**"Package manager not found"**
- Install the appropriate package manager for your system
- On macOS: Install Homebrew from https://brew.sh
- On Linux: Install apt, yum, or pacman

**"Permission denied"**
- Ensure you have sudo access for system package installation
- On macOS, Homebrew doesn't require sudo

**"Dependencies installed but plugin still not working"**
- Restart Neovim to refresh the PATH
- Check if the tools are in your PATH: `which curl`
- Run `:DependencyCheck` to verify installation

### Manual Installation

If automatic installation fails, you can install dependencies manually:

**macOS:**
```bash
brew install curl jq fd ripgrep fzf node python3 go rustc eza lazygit htop bat
```

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install curl jq fd-find ripgrep fzf nodejs python3 golang-go rustc
```

**CentOS/RHEL:**
```bash
sudo yum install curl jq fd ripgrep fzf nodejs python3 golang rustc
```

**Arch:**
```bash
sudo pacman -S curl jq fd ripgrep fzf nodejs python go rust
```

This dependency management system ensures a smooth, automated setup experience for your Neovim configuration! 🚀
