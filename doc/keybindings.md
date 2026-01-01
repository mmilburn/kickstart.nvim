# Keybindings Reference

Complete reference for all keybindings in this Neovim configuration.

## Table of Contents

- [Leader Key](#leader-key)
- [General Navigation](#general-navigation)
- [LSP Operations](#lsp-operations)
- [Telescope (Fuzzy Finder)](#telescope-fuzzy-finder)
- [Completion](#completion)
- [Git Operations](#git-operations)
- [Treesitter Textobjects](#treesitter-textobjects)
- [Refactoring](#refactoring)
- [Debugging](#debugging)
- [Editing](#editing)
- [File Explorer](#file-explorer)
- [Toggles](#toggles)
- [Quick Reference Card](#quick-reference-card)

## Leader Key

The leader key is **Space** (`<leader>` = ` `).

Press Space to see available keybindings organized by category (thanks to which-key).

## General Navigation

| Key | Mode | Action | Source |
| ----- | ------ | -------- | -------- |
| `<Esc>` | Normal | Clear search highlights | keymaps.lua:6 |
| `<C-h>` | Normal | Move focus to left window | keymaps.lua:32 |
| `<C-j>` | Normal | Move focus to lower window | keymaps.lua:34 |
| `<C-k>` | Normal | Move focus to upper window | keymaps.lua:35 |
| `<C-l>` | Normal | Move focus to right window | keymaps.lua:33 |
| `<Esc><Esc>` | Terminal | Exit terminal mode | keymaps.lua:17 |
| `<leader>q` | Normal | Open diagnostic location list | keymaps.lua:9 |

## LSP Operations

LSP keybindings are available only when an LSP server is attached to the buffer.

### Core LSP Actions

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `K` | Normal | Hover documentation | lspconfig.lua:86 |
| `grn` | Normal | Rename symbol | lspconfig.lua:90 |
| `gra` | Normal, Visual | Code action (quick fixes) | lspconfig.lua:94 |

### Navigation

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `grd` | Normal | Go to definition | lspconfig.lua:106 |
| `grD` | Normal | Go to declaration | lspconfig.lua:110 |
| `gri` | Normal | Go to implementation | lspconfig.lua:101 |
| `grr` | Normal | Go to references (Telescope) | lspconfig.lua:97 |
| `grt` | Normal | Go to type definition | lspconfig.lua:123 |
| `gO` | Normal | Document symbols (Telescope) | lspconfig.lua:114 |
| `gW` | Normal | Workspace symbols (Telescope) | lspconfig.lua:118 |
| `<C-t>` | Normal | Jump back (built-in) | vim default |
| `<C-o>` | Normal | Jump to older position | vim default |
| `<C-i>` | Normal | Jump to newer position | vim default |

### Formatting

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `<leader>f` | Normal, Visual, Operator | Format buffer or range | conform.lua:8 |

**Note:** Format on save is enabled by default for most file types (except C/C++).

## Telescope (Fuzzy Finder)

All Telescope commands start with `<leader>s` (Search).

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `<leader>sh` | Normal | Search help tags | telescope.lua:77 |
| `<leader>sk` | Normal | Search keymaps | telescope.lua:78 |
| `<leader>sf` | Normal | Search files | telescope.lua:79 |
| `<leader>ss` | Normal | Select Telescope picker | telescope.lua:80 |
| `<leader>sw` | Normal, Visual | Search current word | telescope.lua:81 |
| `<leader>sg` | Normal | Live grep (search in files) | telescope.lua:82 |
| `<leader>sd` | Normal | Search diagnostics | telescope.lua:83 |
| `<leader>sr` | Normal | Resume last search | telescope.lua:84 |
| `<leader>s.` | Normal | Search recent files | telescope.lua:85 |
| `<leader>s/` | Normal | Live grep in open files | telescope.lua:99 |
| `<leader>sn` | Normal | Search Neovim config files | telescope.lua:107 |
| `<leader>/` | Normal | Fuzzy search in current buffer | telescope.lua:89 |
| `<leader><leader>` | Normal | Find open buffers | telescope.lua:86 |

### Inside Telescope

| Key | Mode | Action |
|-----|------|--------|
| `<C-n>` / `<Down>` | Insert | Next item |
| `<C-p>` / `<Up>` | Insert | Previous item |
| `<C-c>` / `<Esc>` | Insert | Close Telescope |
| `<CR>` | Insert | Select item |
| `<C-x>` | Insert | Open in horizontal split |
| `<C-v>` | Insert | Open in vertical split |
| `<C-t>` | Insert | Open in new tab |
| `<C-u>` | Insert | Scroll preview up |
| `<C-d>` | Insert | Scroll preview down |
| `<C-/>` | Insert | Show mappings help |
| `<C-Enter>` | Insert | Fuzzy refine search |
| `?` | Normal | Show mappings help |

## Completion

Completion appears automatically as you type. Powered by blink.cmp.

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `<C-y>` | Insert | Accept completion | blink-cmp.lua:40 |
| `<C-n>` | Insert | Next suggestion | blink-cmp.lua:55 |
| `<C-p>` | Insert | Previous suggestion | blink-cmp.lua:55 |
| `<Up>` | Insert | Previous suggestion | blink-cmp.lua:55 |
| `<Down>` | Insert | Next suggestion | blink-cmp.lua:55 |
| `<C-space>` | Insert | Trigger completion / Toggle docs | blink-cmp.lua:54 |
| `<C-e>` | Insert | Hide completion menu | blink-cmp.lua:56 |
| `<C-k>` | Insert | Toggle signature help | blink-cmp.lua:57 |
| `<Tab>` | Insert | Next snippet placeholder | blink-cmp.lua:53 |
| `<S-Tab>` | Insert | Previous snippet placeholder | blink-cmp.lua:53 |

## Git Operations

### Hunk Operations (gitsigns)

All Git hunk operations start with `<leader>h`.

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `]c` | Normal | Jump to next git change | gitsigns.lua:46 |
| `[c` | Normal | Jump to previous git change | gitsigns.lua:54 |
| `<leader>hs` | Normal | Stage hunk | gitsigns.lua:71 |
| `<leader>hs` | Visual | Stage selected hunk | gitsigns.lua:64 |
| `<leader>hr` | Normal | Reset hunk | gitsigns.lua:72 |
| `<leader>hr` | Visual | Reset selected hunk | gitsigns.lua:67 |
| `<leader>hS` | Normal | Stage entire buffer | gitsigns.lua:73 |
| `<leader>hu` | Normal | Stage hunk | gitsigns.lua:74 |
| `<leader>hR` | Normal | Reset entire buffer | gitsigns.lua:75 |
| `<leader>hp` | Normal | Preview hunk diff | gitsigns.lua:76 |
| `<leader>hb` | Normal | Show blame for line | gitsigns.lua:77 |
| `<leader>hd` | Normal | Diff against index | gitsigns.lua:78 |
| `<leader>hD` | Normal | Diff against last commit | gitsigns.lua:79 |

### Neogit

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `<leader>gg` | Normal | Open Neogit | neogit.lua:10 |

## Treesitter Textobjects

Structure-aware text manipulation using Treesitter AST.

### Selection

Use in Visual mode or with operators (`d`, `y`, `c`, etc.).

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `<C-s>` | Normal, Visual | Expand selection to larger node | treesitter.lua:26 |
| `<Backspace>` | Visual | Shrink selection | treesitter.lua:29 |
| `af` | Operator, Visual | Around function (includes signature) | treesitter.lua:57 |
| `if` | Operator, Visual | Inside function (body only) | treesitter.lua:58 |
| `ac` | Operator, Visual | Around class | treesitter.lua:60 |
| `ic` | Operator, Visual | Inside class | treesitter.lua:61 |
| `aa` | Operator, Visual | Around parameter/argument | treesitter.lua:63 |
| `ia` | Operator, Visual | Inside parameter/argument | treesitter.lua:64 |

**Examples:**
- `dif` - Delete inside function
- `vaf` - Select around function (including signature)
- `yic` - Yank inside class
- `caa` - Change around parameter

### Navigation

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `]f` | Normal | Go to next function start | treesitter.lua:71 |
| `[f` | Normal | Go to previous function start | treesitter.lua:76 |
| `]C` | Normal | Go to next class start | treesitter.lua:72 |
| `[C` | Normal | Go to previous class start | treesitter.lua:77 |
| `]a` | Normal | Go to next parameter | treesitter.lua:73 |
| `[a` | Normal | Go to previous parameter | treesitter.lua:78 |

**Note:** `]c` and `[c` are used for git changes. Class navigation uses capital `C`.

### Parameter Swapping

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `<leader>a` | Normal | Swap parameter with next | treesitter.lua:84 |
| `<leader>A` | Normal | Swap parameter with previous | treesitter.lua:87 |

## Refactoring

All refactoring operations require visual selection.

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `<leader>re` | Visual | Extract function | refactoring.lua:9 |
| `<leader>rf` | Visual | Extract function to file | refactoring.lua:17 |
| `<leader>rv` | Visual | Extract variable | refactoring.lua:25 |
| `<leader>ri` | Normal, Visual | Inline variable | refactoring.lua:33 |

**Workflow:**
1. Select code in visual mode
2. Press refactoring keybinding
3. Enter name when prompted
4. Code is refactored automatically

## Debugging

DAP (Debug Adapter Protocol) keybindings.

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `<F5>` | Normal | Start debugging / Continue | debug.lua:35 |
| `<F1>` | Normal | Step into function | debug.lua:42 |
| `<F2>` | Normal | Step over line | debug.lua:49 |
| `<F3>` | Normal | Step out of function | debug.lua:56 |
| `<F7>` | Normal | Toggle debug UI | debug.lua:78 |
| `<leader>b` | Normal | Toggle breakpoint | debug.lua:63 |
| `<leader>B` | Normal | Set conditional breakpoint | debug.lua:70 |

**Debug Workflow:**
1. Set breakpoint with `<leader>b`
2. Start debugging with `<F5>`
3. Use `<F1>`, `<F2>`, `<F3>` to step through code
4. Toggle UI with `<F7>` to see variables

## Editing

### Comments (mini.comment)

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `gcc` | Normal | Toggle line comment | mini.lua:24 |
| `gc` | Visual | Toggle comment on selection | mini.lua:24 |
| `gcap` | Normal | Toggle comment on paragraph | mini.lua:24 |
| `gcip` | Normal | Toggle comment inside paragraph | - |

### Surround (mini.surround)

| Key | Mode | Action | Example |
|-----|------|--------|---------|
| `sa{motion}{char}` | Normal | Add surround | `saiw)` - surround word with () |
| `sd{char}` | Normal | Delete surround | `sd'` - delete surrounding ' |
| `sr{old}{new}` | Normal | Replace surround | `sr)'` - replace ) with ' |

### Other

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| Auto-closing | Insert | Brackets, quotes auto-close | autopairs.lua |
| Auto-indent detection | - | Detects tabs vs spaces | guess-indent.nvim |

## File Explorer

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `\` | Normal | Reveal current file or open Neo-tree | neo-tree.lua |

### Inside Neo-tree

| Key | Action |
|-----|--------|
| `<CR>` | Open file/folder |
| `a` | Add file/folder |
| `d` | Delete |
| `r` | Rename |
| `y` | Copy |
| `x` | Cut |
| `p` | Paste |
| `R` | Refresh |
| `?` | Show help |

## Toggles

All toggle commands start with `<leader>t`.

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `<leader>td` | Normal | Toggle diagnostics on/off | lspconfig.lua:126 |
| `<leader>th` | Normal | Toggle inlay hints | lspconfig.lua:164 |
| `<leader>tb` | Normal | Toggle git blame line | gitsigns.lua:83 |
| `<leader>tD` | Normal | Toggle git deleted preview | gitsigns.lua:84 |

## Quick Reference Card

### Most Used Commands

```
Navigation:        <C-h/j/k/l>     Window movement
                   K               Hover docs
                   grd             Go to definition
                   grr             Find references

Search:            <leader>sf      Find files
                   <leader>sg      Live grep
                   <leader><leader> Switch buffers

Git:               ]c / [c         Next/prev change
                   <leader>hp      Preview hunk
                   <leader>hs      Stage hunk

Completion:        <C-y>           Accept
                   <C-n/p>         Navigate
                   <C-space>       Trigger/docs

Debug:             F5              Start/Continue
                   F1/F2/F3        Step into/over/out
                   <leader>b       Breakpoint

Editing:           gcc             Comment line
                   <leader>f       Format
                   <leader>re      Extract function (visual)
```

### Keybinding Conflicts Resolution

This configuration has resolved the following keybinding conflicts:

1. **`]c` / `[c]`**: Reserved for Git hunk navigation (gitsigns)
   - Class navigation uses `]C` / `[C` (capital C) instead

2. **`<C-space>`**: Reserved for completion menu (blink.cmp)
   - Incremental selection uses `<C-s>` instead

## Learning Tips

1. **Use which-key**: Press `<Space>` and wait - you'll see all available bindings
2. **Practice categories**: Focus on one category at a time (e.g., LSP operations)
3. **Use Telescope help**: `<leader>sh` to search Neovim documentation
4. **Check this file**: Come back here when you forget a binding
5. **Customize**: If a binding doesn't work for you, change it in the source files

## Related Documentation

- [Features Overview](features.md) - What each feature does
- [Plugins](plugins.md) - Detailed plugin information
- [Workflows](workflows.md) - Common development workflows
- [Customization](customization.md) - How to modify keybindings
