# Web Development Setup for Neovim

## 🚀 New Features Added

### ✅ **Enhanced Linting & Formatting**

#### **React & TypeScript Support**
- **ESLint Integration**: Full ESLint support with daemonized `eslint_d` for better performance
- **Prettier Integration**: Automatic code formatting with Prettier
- **TypeScript Support**: Enhanced TypeScript language server with better error handling
- **JSX/TSX Support**: Complete support for React components

#### **CSS & Styling**
- **Stylelint**: CSS/SCSS/Sass/Less linting
- **Tailwind CSS**: Color picker and IntelliSense
- **CSS Highlighting**: Color preview in editor
- **Auto-tagging**: Automatic HTML/JSX tag completion

#### **File Type Support**
- **Vue.js**: Complete Vue.js development support
- **Svelte**: Svelte component support
- **GraphQL**: GraphQL syntax highlighting and LSP
- **Docker**: Dockerfile syntax and linting

### ✅ **Claude AI Integration**

#### **AI-Powered Features**
- **Code Review**: `<leader>cc` - Get AI-powered code reviews
- **Code Generation**: `<leader>cg` - Generate code from descriptions
- **Code Explanation**: `<leader>ce` - Explain complex code
- **Code Refactoring**: `<leader>cr` - AI-assisted refactoring

#### **Setup Requirements**
```bash
# Set your Claude API key
export CLAUDE_API_KEY="your_api_key_here"
```

### ✅ **Git Integration**

#### **Git Operations**
- **Git Signs**: Visual indicators for changes in gutter
- **Diff View**: Side-by-side diff viewing
- **Conflict Resolution**: Easy merge conflict resolution
- **Worktree Management**: Multiple Git worktrees support
- **Git Messenger**: Inline Git blame information

#### **Key Mappings**
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>gd` - Open diff view
- `<leader>gco` - Choose ours in conflict
- `<leader>gct` - Choose theirs in conflict

### ✅ **Debugging Support**

#### **Debug Adapter Protocol (DAP)**
- **Node.js Debugging**: Full Node.js/TypeScript debugging
- **Python Debugging**: Python debugger integration
- **Breakpoints**: Visual breakpoint management
- **Variable Inspection**: Real-time variable watching
- **Call Stack**: Step-through debugging

#### **Debug Key Mappings**
- `<F5>` - Continue debugging
- `<F1>` - Step into
- `<F2>` - Step over
- `<F3>` - Step out
- `<leader>b` - Toggle breakpoint
- `<leader>du` - Toggle debug UI

## 📦 **New Plugins Added**

### **Core Web Development**
1. **typescript.nvim** - Enhanced TypeScript support
2. **tailwindcss-colorizer-cmp** - Tailwind color completion
3. **nvim-highlight-colors** - Color highlighting
4. **nvim-ts-autotag** - Auto HTML/JSX tags
5. **vim-vue** - Vue.js support
6. **vim-svelte** - Svelte support

### **Package Management**
8. **package-info.nvim** - NPM package information
9. **schemastore.nvim** - JSON schema support
10. **markdown-preview.nvim** - Markdown preview
11. **vim-graphql** - GraphQL support
12. **Dockerfile.vim** - Docker support
13. **vim-dotenv** - Environment file support

### **Git Integration**
14. **gitsigns.nvim** - Git signs and operations
15. **diffview.nvim** - Git diff viewing
16. **git-conflict.nvim** - Merge conflict resolution
17. **git-worktree.nvim** - Git worktree management
18. **git-messenger.vim** - Inline Git blame

### **Debugging**
19. **nvim-dap** - Debug Adapter Protocol
20. **nvim-dap-ui** - Debug UI
21. **nvim-dap-virtual-text** - Debug virtual text
22. **telescope-dap.nvim** - DAP telescope integration

### **AI Integration**
23. **nabla.nvim** - LaTeX math rendering
24. **Custom Claude Integration** - AI code assistance

## 🔧 **Configuration Files**

### **New Configuration Files**
- `lua/jaybates/plugins/web-dev.lua` - Web development plugins
- `lua/jaybates/plugins/git.lua` - Git integration
- `lua/jaybates/plugins/debugging.lua` - Debugging setup
- `lua/jaybates/plugins/claude.lua` - Claude AI integration

### **Enhanced Existing Files**
- `nvim-lint.lua` - Enhanced with React/TS linting
- `mason.lua` - Added web dev tools and linters
- `conform.lua` - Enhanced formatting for all web languages

## 🎯 **Key Mappings Summary**

### **Claude AI**
- `<leader>cc` - Code review
- `<leader>cg` - Generate code
- `<leader>ce` - Explain code
- `<leader>cr` - Refactor code

### **Git Operations**
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>gd` - Open diff view
- `<leader>gco` - Choose ours
- `<leader>gct` - Choose theirs
- `<leader>gm` - Git messenger

### **Debugging**
- `<F5>` - Continue
- `<F1>` - Step into
- `<F2>` - Step over
- `<F3>` - Step out
- `<leader>b` - Toggle breakpoint
- `<leader>du` - Toggle debug UI

### **Linting & Formatting**
- `<leader>l` - Trigger linting
- `<leader>L` - Lint with notification
- `<leader>mp` - Format file/selection

## 🚀 **Installation & Setup**

### **1. Install Dependencies**
```bash
# Node.js (for LSP servers and tools)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Additional tools
sudo apt install fd-find ripgrep

# For debugging
npm install -g @vscode/js-debug
```

### **2. Set Environment Variables**
```bash
# Add to your ~/.bashrc or ~/.zshrc
export CLAUDE_API_KEY="your_claude_api_key_here"
```

### **3. Install Plugins**
```vim
:Lazy sync
:Mason
:TSUpdate
```

### **4. Verify Installation**
```vim
:checkhealth
:Lazy profile
```

## 📋 **Project Setup Examples**

### **React/TypeScript Project**
```json
// package.json
{
  "devDependencies": {
    "@types/react": "^18.0.0",
    "@types/react-dom": "^18.0.0",
    "@typescript-eslint/eslint-plugin": "^6.0.0",
    "@typescript-eslint/parser": "^6.0.0",
    "eslint": "^8.0.0",
    "eslint-plugin-react": "^7.0.0",
    "eslint-plugin-react-hooks": "^4.0.0",
    "prettier": "^3.0.0",
    "typescript": "^5.0.0"
  }
}
```

### **Vue.js Project**
```json
// package.json
{
  "devDependencies": {
    "@vue/eslint-config-typescript": "^12.0.0",
    "eslint": "^8.0.0",
    "eslint-plugin-vue": "^9.0.0",
    "prettier": "^3.0.0",
    "typescript": "^5.0.0",
    "vue-tsc": "^1.0.0"
  }
}
```

### **Svelte Project**
```json
// package.json
{
  "devDependencies": {
    "@sveltejs/eslint-config": "^2.0.0",
    "eslint": "^8.0.0",
    "prettier": "^3.0.0",
    "prettier-plugin-svelte": "^3.0.0",
    "svelte": "^4.0.0",
    "svelte-check": "^3.0.0"
  }
}
```

## 🔍 **Troubleshooting**

### **Common Issues**

1. **ESLint not working**
   ```vim
   :Mason
   # Install eslint_d
   ```

2. **Prettier not formatting**
   ```vim
   :Mason
   # Install prettier
   ```

3. **TypeScript errors**
   ```vim
   :Mason
   # Install typescript-language-server
   ```

4. **Claude integration not working**
   ```bash
   # Check API key
   echo $CLAUDE_API_KEY
   ```

5. **Debugging not working**
   ```vim
   :Mason
   # Install node-debug2-adapter
   ```

### **Performance Tips**

1. **Use daemonized linters** (eslint_d, prettierd)
2. **Enable lazy loading** for non-essential plugins
3. **Use telescope extensions** for better performance
4. **Configure file watchers** appropriately

## 📚 **Additional Resources**

- [ESLint Configuration Guide](https://eslint.org/docs/user-guide/configuring/)
- [Prettier Configuration](https://prettier.io/docs/en/configuration.html)
- [TypeScript in Neovim](https://github.com/jose-elias-alvarez/typescript.nvim)
- [Debug Adapter Protocol](https://microsoft.github.io/debug-adapter-protocol/)
- [Claude API Documentation](https://docs.anthropic.com/)

## 🎉 **What's Next?**

Your Neovim configuration is now fully equipped for modern web development with:
- ✅ Complete React/TypeScript support
- ✅ AI-powered code assistance
- ✅ Advanced Git integration
- ✅ Professional debugging tools
- ✅ Comprehensive linting and formatting
- ✅ Support for all major web frameworks

Happy coding! 🚀
