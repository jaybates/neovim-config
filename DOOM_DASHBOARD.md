# Doom Emacs Style Dashboard

## 🎉 **Your Neovim now has a Doom Emacs-style startup screen!**

### ✅ **What You Get**

#### **🎨 Beautiful Visual Design**
- **Multiple ASCII Art Headers**: Randomly selected on each startup
- **Boxed Layout**: Clean, organized sections with borders
- **System Information**: OS, uptime, plugin count, LSP servers
- **Recent Files**: Last 5 files with icons and paths
- **Quick Actions**: Easy access to common commands

#### **📊 System Information Panel**
```
┌─ System Information ──────────────────────────────────────────────┐
│ OS: macOS            │ Uptime: 2h 15m                            │
│ Plugins: 45          │ LSP Servers: 3                            │
└─────────────────────────────────────────────────────────────────┘
```

#### **📁 Recent Files Panel**
```
┌─ Recent Files ─────────────────────────────────────────────────────┐
│ 📄 init.lua          │ ~/.config/nvim/init.lua                   │
│ 📄 package.json      │ ~/Projects/my-app/package.json            │
│ 📄 main.tsx          │ ~/Projects/my-app/src/main.tsx            │
│ 📄 styles.css        │ ~/Projects/my-app/src/styles.css          │
│ 📄 README.md         │ ~/Projects/my-app/README.md               │
└─────────────────────────────────────────────────────────────────┘
```

#### **⚡ Quick Actions Panel**
```
┌─ Quick Actions ──────────────────────────────────────────────────┐
│ [e]  New File          [f]  Find Files        [g]  Live Grep    │
│ [r]  Recent Files      [p]  Projects          [t]  File Tree    │
│ [s]  Sessions          [c]  Config            [q]  Quit         │
└─────────────────────────────────────────────────────────────────┘
```

### 🎯 **Key Mappings**

| Key | Action | Description |
|-----|--------|-------------|
| `e` | New File | Create a new file |
| `f` | Find Files | Open telescope file finder |
| `g` | Live Grep | Search across files |
| `r` | Recent Files | Show recent files |
| `p` | Projects | Open project manager |
| `t` | File Tree | Toggle file explorer |
| `s` | Sessions | Load/save sessions |
| `c` | Config | Open Neovim config |
| `q` | Quit | Quit Neovim |

### 🔧 **Features**

#### **🔄 Dynamic Content**
- **Random Headers**: Different ASCII art on each startup
- **Live System Info**: Real-time uptime and statistics
- **Recent Files**: Automatically updated file history
- **Plugin Count**: Shows total installed plugins
- **LSP Status**: Displays active language servers

#### **🎨 Visual Enhancements**
- **File Icons**: Nerd font icons for different file types
- **Color Coding**: Different colors for different sections
- **Clean Layout**: Organized, easy-to-read design
- **Responsive**: Adapts to different terminal sizes

#### **⚡ Performance**
- **Lazy Loading**: Only loads when needed
- **Efficient Updates**: Minimal resource usage
- **Fast Rendering**: Quick startup times

### 📦 **New Plugins Added**

1. **doom-dashboard.lua** - Main dashboard configuration
2. **sessions.lua** - Session management
3. **projects.lua** - Project management

### 🚀 **Installation**

The dashboard is automatically enabled. To see it:

1. **Restart Neovim**:
   ```bash
   nvim
   ```

2. **Or reload configuration**:
   ```vim
   :source ~/.config/nvim/init.lua
   ```

### 🎨 **Customization**

#### **Change Headers**
Edit `lua/jaybates/plugins/doom-dashboard.lua` and modify the `get_header()` function to add your own ASCII art.

#### **Add Quick Actions**
Add new buttons in the `dashboard.section.buttons.val` section:

```lua
dashboard.button("x", "🔧 New Action", "<cmd>YourCommand<CR>"),
```

#### **Modify System Info**
Customize the system information in the `get_system_info()` function.

#### **Change Colors**
The dashboard uses your current colorscheme. Change colors by switching themes:
```vim
:colorscheme catppuccin
```

### 🔍 **Troubleshooting**

#### **Dashboard Not Showing**
1. Check if the plugin is enabled:
   ```vim
   :Lazy
   ```

2. Reload the configuration:
   ```vim
   :source ~/.config/nvim/init.lua
   ```

#### **Recent Files Not Showing**
Recent files are based on Vim's `oldfiles`. Make sure you have some file history:
```vim
:oldfiles
```

#### **System Info Not Accurate**
The system information is calculated at startup. Restart Neovim to see updated values.

### 🎉 **Enjoy Your New Dashboard!**

Your Neovim now has a professional, Doom Emacs-inspired startup screen that provides:
- ✅ Beautiful visual design
- ✅ Quick access to common actions
- ✅ System information at a glance
- ✅ Recent files for easy access
- ✅ Project management integration
- ✅ Session management support

The dashboard makes Neovim feel more like a modern IDE while maintaining the power and flexibility of Vim! 🚀
