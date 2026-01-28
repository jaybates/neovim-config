# Neovim IDE Usage Guide

A practical guide to using this Neovim configuration as your primary IDE for navigating and interacting with files and codebases. **Leader key is `<Space>`.**

---

## Table of Contents

1. [Getting Started](#getting-started)
2. [File & Project Navigation](#file--project-navigation)
3. [Buffer & Window Management](#buffer--window-management)
4. [Code Navigation & LSP](#code-navigation--lsp)
5. [Search & Find](#search--find)
6. [Editing & Refactoring](#editing--refactoring)
7. [Git Workflow](#git-workflow)
8. [Sessions & Projects](#sessions--projects)
9. [Diagnostics & Troubleshooting](#diagnostics--troubleshooting)
10. [Terminal & Tools](#terminal--tools)
11. [Quick Reference](#quick-reference)

---

## Getting Started

### Dashboard (Startup Screen)

On launch you see the Doom-style dashboard with:

- **Recent files** – last 5 edited files
- **Quick actions** – same as the buttons below

| Key | Action |
|-----|--------|
| `e` | New file |
| `f` | Find files (Telescope) |
| `g` | Live grep |
| `r` | Recent files |
| `p` | Projects |
| `t` | File tree (NvimTree) |
| `s` | Sessions |
| `c` | Open Neovim config |
| `q` | Quit |

### Discovering Keybindings

Press **`<Space>`** and wait ~500ms. **Which-key** will show all available leader keybindings for your current context. Use this whenever you forget a command.

---

## File & Project Navigation

### File Tree (NvimTree)

| Key | Action |
|-----|--------|
| `<Space>ee` | Toggle file explorer |
| `<Space>ef` | Toggle file explorer **focused on current file** |
| `<Space>ec` | Collapse file explorer |
| `<Space>er` | Refresh file explorer |

**In the file tree:** Use `a` (new file/dir), `d` (delete), `r` (rename), or open the help with `?`.

### Fuzzy Find (Telescope)

Primary way to open and search files:

| Key | Action |
|-----|--------|
| `<Space>ff` | **Find files** – fuzzy search by path (uses `fd`, respects .gitignore) |
| `<Space>fg` | **Live grep** – search file contents as you type |
| `<Space>fb` | **Find buffers** – switch among open buffers |
| `<Space>fh` | **Find help tags** – search `:help` |
| `<Space>fr` | **Recent files** – recently opened files |
| `<Space>fc` | **Grep string** – search for word under cursor |

**Inside Telescope:**

| Key | Action |
|-----|--------|
| `Ctrl+j` / `Ctrl+k` | Move selection |
| `Ctrl+u` / `Ctrl+d` | Scroll preview |
| `Ctrl+q` | Send selection(s) to quickfix and open Trouble |
| `Ctrl+t` | Open selection in Trouble |
| `Ctrl+s` | Open in **horizontal** split |
| `Ctrl+v` | Open in **vertical** split |
| `Ctrl+\` | Open in **new tab** |
| `Ctrl+c` | Close Telescope |

### Projects

| Key | Action |
|-----|--------|
| `<Space>p` | **Projects** – list detected projects (`.git`, `package.json`, etc.) and switch into one |

Use this to jump between projects; cwd updates when you pick a project.

### Classic File Explorer

| Key | Action |
|-----|--------|
| `<Space>pv` | Open built-in file explorer (netrw) |

---

## Buffer & Window Management

### Buffers (Tabs)

The **bufferline** at the top shows open buffers as tabs.

| Key | Action |
|-----|--------|
| `Shift+h` | Previous buffer |
| `Shift+l` | Next buffer |
| `<Space>bd` | Delete current buffer |
| `<Space>ba` | Delete all buffers |

Use **`<Space>fb`** (Telescope buffers) to search and pick a buffer by name.

### Windows (Splits)

| Key | Action |
|-----|--------|
| `Ctrl+h` | Focus **left** window |
| `Ctrl+j` | Focus **below** window |
| `Ctrl+k` | Focus **above** window |
| `Ctrl+l` | Focus **right** window |

**Resize:**

| Key | Action |
|-----|--------|
| `Ctrl+Up` | Increase height |
| `Ctrl+Down` | Decrease height |
| `Ctrl+Left` | Decrease width |
| `Ctrl+Right` | Increase width |

Splits open **below** and to the **right** by default (see `options.lua`).

---

## Code Navigation & LSP

These require a language server (e.g. via Mason) to be installed and attached.

### Go to Symbol

| Key | Action |
|-----|--------|
| `gd` | **Definitions** (Telescope list) |
| `gD` | **Declaration** |
| `gR` | **References** (Telescope list) |
| `gi` | **Implementations** (Telescope list) |
| `gt` | **Type definitions** (Telescope list) |

### Document & Workspace Symbols

| Key | Action |
|-----|--------|
| `<Space>ds` | **Document symbols** (current file) – functions, classes, etc. |
| `<Space>ws` | **Workspace symbols** – project-wide symbols |

### LSP Actions

| Key | Action |
|-----|--------|
| `K` | **Hover** – documentation for symbol under cursor |
| `<Space>ca` | **Code action** (normal or visual selection) |
| `<Space>rn` | **Rename** symbol (project-wide) |
| `<Space>rs` | **Restart LSP** |

### Completion (nvim-cmp)

Completions appear automatically; sources include LSP, snippets, buffer, and path.

| Key | Action |
|-----|--------|
| `Ctrl+Space` | Manually trigger completion |
| `Ctrl+j` / `Ctrl+k` | Move in completion list |
| `Ctrl+b` / `Ctrl+f` | Scroll documentation |
| `Enter` | Confirm selection (does not auto-select first item) |
| `Ctrl+e` | Close completion |
| `Ctrl+l` | Expand/jump forward in snippet |
| `Ctrl+h` | Jump backward in snippet |

---

## Search & Find

### In Files

- **`<Space>fg`** – Live grep (content search).
- **`<Space>fc`** – Grep for the word under the cursor.

### In Current Buffer

- **`/`** or **`?`** – Search (with completion from nvim-cmp).
- **`Esc`** – Clear search highlight.

Search is **incsearch** (matches as you type), **ignorecase** by default, **smartcase** when you use capitals.

### Search & Replace

| Key | Action |
|-----|--------|
| `<Space>sr` | Search and replace **word under cursor** (prompts for replacement) |
| `<Space>sr` (visual) | Search and replace **selected text** |

### Substitute (Quick In-Place Replace)

| Key | Action |
|-----|--------|
| `s` + motion | Replace text covered by motion (e.g. `sip` = replace inner paragraph) |
| `ss` | Replace current line |
| `S` | Replace to end of line |
| `s` (visual) | Replace selection |

---

## Editing & Refactoring

### Comments

| Key | Action |
|-----|--------|
| `<Space>/` | Toggle line comment (current line) |
| `<Space>/` (visual) | Toggle comment for selection |

Uses **Comment.nvim** (context-aware for the language).

### Formatting

| Key | Action |
|-----|--------|
| `<Space>mp` | **Format** current buffer (or selection in visual mode) |

Uses **Conform** with LSP fallback.

### Moving Lines

| Key | Action |
|-----|--------|
| `Alt+j` | Move line(s) down |
| `Alt+k` | Move line(s) up |

Works in normal, insert, and visual mode.

### Surround (nvim-surround)

Wrap or change delimiters around text:

- **`ys{motion}{char}`** – Add surround (e.g. `ysiw"` = wrap word in `"`).
- **`cs{old}{new}`** – Change surround (e.g. `cs"'` = change `"` to `'`).
- **`ds{char}`** – Delete surround (e.g. `ds"`).
- **Visual mode:** Select text, then **`S`** + character to add surround.

### Text Objects (Treesitter)

Select and move by semantic units:

**Selection:**

| Key | Object |
|-----|--------|
| `af` / `if` | Around / inside **function** |
| `ac` / `ic` | Around / inside **class** |
| `am` / `im` | Around / inside **method/function** |
| `aa` / `ia` | Around / inside **parameter** |
| `ai` / `ii` | Around / inside **conditional** |
| `al` / `il` | Around / inside **loop** |
| `a=` / `i=` | Assignment (outer/inner) |
| `a:` / `i:` | Object property (outer/inner) |

**Movement:**

| Key | Action |
|-----|--------|
| `]f` / `[f` | Next / previous **function call** |
| `]m` / `[m` | Next / previous **function definition** |
| `]c` / `[c` | Next / previous **class** |
| `]i` / `[i` | Next / previous **conditional** |
| `]l` / `[l` | Next / previous **loop** |
| `;` / `,` | Repeat last move / opposite direction |

**Swap:**

| Key | Action |
|-----|--------|
| `<Space>na` | Swap parameter with next |
| `<Space>pa` | Swap parameter with previous |
| `<Space>n:` / `<Space>p:` | Swap object property |
| `<Space>nm` / `<Space>pm` | Swap function with next/previous |

### Incremental Selection (Treesitter)

| Key | Action |
|-----|--------|
| `Ctrl+Space` | Start / expand selection by syntax node |
| `Backspace` | Shrink selection |

---

## Git Workflow

### Gitsigns (Inline Signs & Hunks)

| Key | Action |
|-----|--------|
| `]c` / `[c` | Next / previous **hunk** |
| `<Space>hs` | **Stage hunk** (normal or visual) |
| `<Space>hr` | **Reset hunk** |
| `<Space>hS` | Stage **buffer** |
| `<Space>hu` | **Undo** stage hunk |
| `<Space>hR` | **Reset** buffer |
| `<Space>hp` | **Preview** hunk |
| `<Space>hb` | **Blame** line (full) |
| `<Space>tb` | Toggle **inline blame** |
| `<Space>hd` | **Diff** current file |
| `<Space>hD` | Diff against parent (e.g. `~`) |
| `<Space>td` | Toggle **deleted** view |

**Text object:** `ih` in visual/operator mode = **select hunk**.

### Diffview

| Key | Action |
|-----|--------|
| `<Space>gd` | **Open diff view** (e.g. working tree vs index) |
| `<Space>gD` | **Close** diff view |
| `<Space>gf` | **File history** (log for current file) |

### Git (Telescope)

| Key | Action |
|-----|--------|
| `<Space>gs` | **Git status** |
| `<Space>gb` | **Git branches** |
| `<Space>gc` | **Git commits** |

### Conflicts & Worktrees

**Conflicts:**

| Key | Action |
|-----|--------|
| `<Space>gco` | Choose **ours** |
| `<Space>gct` | Choose **theirs** |
| `<Space>gcb` | Choose **both** |
| `<Space>gc0` | Choose **none** |
| `<Space>gcn` / `<Space>gcp` | Next / previous conflict |

**Worktrees:**

| Key | Action |
|-----|--------|
| `<Space>gwt` | List **worktrees** (Telescope) |
| `<Space>gwc` | **Create** worktree |

### Other

| Key | Action |
|-----|--------|
| `<Space>gm` | **Git messenger** – blame popup for line under cursor |
| `<Space>tg` | **LazyGit** (terminal UI) |

---

## Sessions & Projects

### Sessions (Session Manager)

Sessions save and restore buffers, layout, and cwd.

| Key | Action |
|-----|--------|
| `<Space>ss` | **Save current** session |
| `<Space>sS` | **Save session** (name it) |
| `<Space>sl` | **Load last** session |
| `<Space>sf` | **Load session** (pick from list) |
| `<Space>sd` | **Delete** session |

Last session is auto-saved on exit when possible.

### Projects

| Key | Action |
|-----|--------|
| `<Space>p` | **Projects** – switch project (Telescope); updates cwd |

---

## Diagnostics & Troubleshooting

### Diagnostics (LSP)

| Key | Action |
|-----|--------|
| `<Space>d` | **Line diagnostics** (float for current line) |
| `<Space>D` | **Buffer diagnostics** (Telescope for current buffer) |
| `]d` / `[d` | **Next** / **previous** diagnostic in buffer |

### Trouble (Diagnostics & Lists)

| Key | Action |
|-----|--------|
| `<Space>xx` | **Toggle** Trouble |
| `<Space>xw` | **Workspace diagnostics** |
| `<Space>xd` | **Document diagnostics** |
| `<Space>xq` | **Quickfix** list |
| `<Space>xl` | **Location** list |
| `<Space>xt` | **Todo** comments in Trouble |

### Quickfix

| Key | Action |
|-----|--------|
| `Ctrl+q` | **Open** quickfix list |
| `]q` / `[q` | **Next** / **previous** quickfix item |

### Todo Comments

| Key | Action |
|-----|--------|
| `]t` / `[t` | **Next** / **previous** TODO/FIXME/etc. |

---

## Terminal & Tools

### ToggleTerm

| Key | Action |
|-----|--------|
| `<Space>tt` | **Toggle** terminal (default layout) |
| `<Space>tf` | **Floating** terminal |
| `<Space>th` | **Horizontal** terminal |
| `<Space>tv` | **Vertical** terminal |
| `<Space>tT` | Terminal in **tab** |
| `<Space>t1` … `<Space>t4` | Named terminals 1–4 |

**Inside terminal:**

- **`Esc` twice** (or **`Ctrl+\` then `Ctrl+n`**) – exit terminal mode.
- **`Ctrl+h/j/k/l`** – move focus between windows (same as in normal mode).

### Other

| Key | Action |
|-----|--------|
| `<Space>tg` | **LazyGit** |
| `<Space>tn` | **Node** REPL (float) |
| `<Space>tp` | **Python** REPL (float) |

---

## Harpoon (Fast File Switching)

Pin frequently used files and jump with one key:

| Key | Action |
|-----|--------|
| `<Space>ha` | **Add** current file to Harpoon |
| `<Space>hh` | **Menu** – list and pick Harpoon files |
| `<Space>h1` … `<Space>h4` | **Jump** to Harpoon slot 1–4 |

Typical workflow: open 3–4 core files, `<Space>ha` each, then use `<Space>h1`–`<Space>h4` to switch without searching.

---

## UI & Display

| Key | Action |
|-----|--------|
| `<Space>n` | Toggle **line numbers** |
| `<Space>rn` | **Rename** symbol (LSP buffers) / Toggle **relative** line numbers (other buffers) |
| `<Space>w` | Toggle **word wrap** |
| `<Space>s` | Toggle **spell check** |

---

## Quick Reference

### Leader is `<Space>`

| Area | Keys |
|------|------|
| **Files** | `ff` find, `fg` grep, `fb` buffers, `fr` recent, `fc` cursor word |
| **Explorer** | `ee` tree, `ef` tree at file, `ec` collapse, `er` refresh |
| **LSP** | `gd`/`gD`/`gi`/`gt`/`gR` (no leader), `ds` doc symbols, `ws` workspace symbols, `ca` code action, `rn` rename, `rs` restart |
| **Diagnostics** | `d` float, `D` buffer, `xx`/`xw`/`xd`/`xq`/`xl`/`xt` Trouble |
| **Git** | `gd` diffview, `gs` status, `gb` branches, `gc` commits, `ha`/`hh`/`h1`–`h4` Harpoon, `hs`/`hr`/`hp`/`hb` hunks |
| **Session** | `ss` save, `sl` load last, `sf` load, `sd` delete |
| **Edit** | `/` comment, `mp` format, `sr` search-replace |
| **Terminal** | `tt` toggle, `tf` float, `tg` LazyGit |
| **Projects** | `p` projects |

### No-Leader Essentials

- **`gd`** – go to definition  
- **`K`** – hover  
- **`Ctrl+h/j/k/l`** – window focus  
- **`Shift+h` / `Shift+l`** – prev/next buffer  
- **`]d` / `[d`** – next/prev diagnostic  
- **`]c` / `[c`** – next/prev Git hunk  

Use **`<Space>` + pause** to see the full which-key menu for your setup. For more detail on a command, use **`:help <command>`** or **`:help <key>`** where applicable.
