# Features Overview

This document provides a comprehensive overview of all features available in this Neovim configuration.

## Table of Contents

- [Language Support](#language-support)
- [Code Completion](#code-completion)
- [Fuzzy Finding](#fuzzy-finding)
- [Syntax Highlighting](#syntax-highlighting)
- [Git Integration](#git-integration)
- [Debugging](#debugging)
- [Code Quality](#code-quality)
- [UI Enhancements](#ui-enhancements)
- [Editing Tools](#editing-tools)
- [Architecture](#architecture)

## Language Support

Full LSP (Language Server Protocol) support with auto-installation, formatting, and linting for multiple languages.

### Supported Languages

| Language   | LSP Server     | Formatter             | Linter      | Status |
|------------|----------------|-----------------------|-------------|--------|
| Assembly   | asm_lsp        | asmfmt                | -           | ✓      |
| Bash       | bashls         | -                     | shellcheck  | ✓      |
| Docker     | dockerls       | -                     | hadolint    | ✓      |
| Go         | -              | -                     | -           | Parser only |
| Java       | jdtls          | google-java-format    | -           | ✓ (Spring Boot) |
| Lua        | lua_ls         | stylua                | -           | ✓      |
| Markdown   | -              | -                     | markdownlint| ✓      |
| Python     | -              | black + isort         | flake8      | ✓      |
| Rust       | -              | -                     | -           | Parser only |
| YAML       | yamlls         | -                     | -           | ✓ (docker-compose schemas) |

### Key Capabilities

- **Auto-installation**: LSP servers and tools install automatically via Mason
- **Format on save**: Enabled for most languages (except C/C++)
- **Real-time linting**: Runs on buffer enter, save, and insert leave
- **Inlay hints**: Type hints and parameter names (toggleable with `<leader>th`)
- **Auto-import**: Accepting completions automatically adds imports

### LSP Features

- **Go to definition** (`grd`) - Jump to where symbol is defined
- **Find references** (`grr`) - Find all usages of symbol
- **Rename** (`grn`) - Rename symbol across entire project
- **Code actions** (`gra`) - Quick fixes and refactorings
- **Hover documentation** (`K`) - View docs for symbol under cursor
- **Signature help** - Function parameter info while typing

**Config:** `lua/kickstart/plugins/lspconfig.lua`, `lua/kickstart/plugins/conform.lua`, `lua/kickstart/plugins/lint.lua`

**Keybindings:** See [keybindings.md](keybindings.md#lsp-operations)

## Code Completion

Modern, fast completion engine with intelligent suggestions and snippet support.

### Features

- **blink.cmp**: High-performance completion with Rust fuzzy matching
- **Multi-source completions**:
  - LSP (symbols, functions, variables)
  - File paths (intelligent path completion)
  - Snippets (pre-made code templates)
  - Buffer words (only in markdown/text files)
  - Neovim Lua API (when editing config)

- **Snippet engine**: LuaSnip with friendly-snippets library
- **Auto-import**: Automatically adds import statements
- **Signature help**: Shows function parameters as you type
- **Smart filtering**: Buffer completions disabled in code files to reduce noise

### Usage

- `<C-y>` - Accept completion
- `<C-n>` / `<C-p>` - Navigate suggestions
- `<C-space>` - Manually trigger or toggle documentation
- `<C-e>` - Close completion menu
- `<Tab>` / `<Shift-Tab>` - Navigate snippet placeholders

**Config:** `lua/kickstart/plugins/blink-cmp.lua`

**Keybindings:** See [keybindings.md](keybindings.md#completion)

## Fuzzy Finding

Fast, powerful searching with fd and fzf integration powered by Telescope.

### Search Capabilities

- **File search**: Find files by name across entire project
- **Live grep**: Search file contents in real-time (ripgrep)
- **Help tags**: Search Neovim documentation
- **LSP symbols**: Find functions, classes, variables
- **Diagnostics**: Search errors and warnings
- **Git files**: Search only tracked files
- **Recent files**: Quick access to previously opened files
- **Buffers**: Switch between open buffers

### Optimizations

- **fd integration**: 2-3x faster than traditional find
- **Smart ignore patterns**: Skips .git/, node_modules/, build/, etc.
- **fzf-native**: C-based fuzzy matching algorithm
- **Hidden file support**: Searches hidden files but excludes .git/

### Common Searches

- `<leader>sf` - Search files
- `<leader>sg` - Live grep (search in file contents)
- `<leader>sw` - Search word under cursor
- `<leader>s.` - Recent files
- `<leader><leader>` - Switch buffers

**Config:** `lua/kickstart/plugins/telescope.lua`

**Keybindings:** See [keybindings.md](keybindings.md#telescope-fuzzy-finder)

## Syntax Highlighting

Advanced syntax highlighting and code understanding via Treesitter AST parsing.

### Core Features

- **AST-based highlighting**: More accurate than regex-based approaches
- **Incremental parsing**: Fast updates as you type
- **Auto-install parsers**: Downloads language parsers automatically
- **Context display**: Shows containing function/class at top of window (max 3 lines)

### Treesitter Textobjects

Structure-aware text manipulation and navigation.

**Selection**:
- `<C-s>` - Incremental selection (expand to larger syntax nodes)
- `<Backspace>` - Decrease selection
- `af` / `if` - Around/inside function
- `ac` / `ic` - Around/inside class
- `aa` / `ia` - Around/inside parameter

**Navigation**:
- `]f` / `[f` - Next/previous function
- `]C` / `[C` - Next/previous class
- `]a` / `[a` - Next/previous parameter

**Manipulation**:
- `<leader>a` - Swap current parameter with next
- `<leader>A` - Swap current parameter with previous

### Supported Languages

Assembly, Bash, C, Diff, Dockerfile, Go, HTML, Java, JSON, Lua, Markdown, Python, Rust, TOML, Vim, YAML

**Config:** `lua/kickstart/plugins/treesitter.lua`

**Keybindings:** See [keybindings.md](keybindings.md#treesitter-textobjects)

## Git Integration

Comprehensive Git workflow support with inline change tracking and full Git interface.

### gitsigns

Inline Git decorations and hunk operations.

**Features**:
- Line-by-line change indicators in sign column
- Hunk preview, staging, and reset
- Blame information
- Navigate between changes
- Visual hunk selection

**Common operations**:
- `]c` / `[c` - Jump to next/previous change
- `<leader>hp` - Preview hunk diff
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>hb` - Show blame for current line

### vim-fugitive

Full-featured Git wrapper for complex operations.

**Usage**:
- `:Git` or `:G` - Run any Git command
- `:Git commit` - Create commit
- `:Git push` - Push changes
- `:Gdiffsplit` - View diff in split
- `:Git blame` - Full blame view

**Config:** `lua/kickstart/plugins/gitsigns.lua`, `lua/kickstart/plugins/fugitive.lua`

**Keybindings:** See [keybindings.md](keybindings.md#git-operations)

## Debugging

Full DAP (Debug Adapter Protocol) support for multiple languages.

### Supported Debuggers

| Language        | Adapter         | Features                      |
|-----------------|-----------------|-------------------------------|
| Go              | delve           | Full debugging support        |
| Java            | java-debug      | Full debugging + test runner  |
| C/C++/Rust/Asm  | codelldb        | LLDB-based debugging          |

### Debug Features

- **Breakpoints**: Set, toggle, conditional breakpoints
- **Step execution**: Step into, over, out
- **Variable inspection**: View values in debug UI
- **Call stack**: Navigate execution stack
- **REPL**: Evaluate expressions during debugging
- **Virtual text**: See variable values inline

### Debug UI

Press `F7` to toggle the debug UI which shows:
- Local variables and their values
- Call stack
- Breakpoints list
- Watches
- REPL console

**Config:** `lua/kickstart/plugins/debug.lua`

**Keybindings:** See [keybindings.md](keybindings.md#debugging)

## Code Quality

Automated formatting and linting for consistent, high-quality code.

### Formatters (via conform.nvim)

- **Lua**: stylua
- **Python**: black + isort (sequential)
- **Java**: google-java-format
- **Assembly**: asmfmt

**Format on save**: Enabled by default (except C/C++)
**Manual format**: `<leader>f`

### Linters (via nvim-lint)

- **Markdown**: markdownlint
- **Docker**: hadolint
- **Python**: flake8
- **Shell**: shellcheck

**Linting triggers**: Buffer enter, save, insert leave

### Refactoring Tools

Structure-aware code refactoring via refactoring.nvim:

- **Extract function** (`<leader>re`) - Extract selection to new function
- **Extract variable** (`<leader>rv`) - Extract expression to variable
- **Inline variable** (`<leader>ri`) - Inline variable at usage sites
- **Extract to file** (`<leader>rf`) - Move function to separate file

**Config:** `lua/kickstart/plugins/conform.lua`, `lua/kickstart/plugins/lint.lua`, `lua/kickstart/plugins/refactoring.lua`

## UI Enhancements

Modern, informative interface with helpful visual aids.

### which-key

Displays available keybindings as you type.

- **Zero delay**: Shows immediately (no timeout)
- **Grouped by purpose**: Search, Toggle, Git Hunk, etc.
- **Contextual**: Only shows relevant bindings
- **Visual**: Icons for mappings (with Nerd Font)

### Neo-tree

Feature-rich file explorer.

- **Tree view**: Visual directory structure
- **Git integration**: Shows file status
- **Toggle**: `\` to show/hide
- **Buffers**: Can also display open buffers
- **Git status**: Can show git changes

### Status Line

Minimal, informative statusline via mini.statusline:
- Current mode
- File name and status
- Line and column position
- Git branch (if in repo)
- Diagnostic count

### Other UI Features

- **todo-comments**: Highlights TODO, FIXME, NOTE, etc. with distinct colors
- **indent-blankline**: Shows indentation guides
- **Transparent background**: Tokyonight theme with transparency enabled
- **Rounded borders**: Diagnostic floats use rounded borders
- **Cursorline**: Highlights current line
- **Relative line numbers**: For easy jumping

**Config:** `lua/kickstart/plugins/which-key.lua`, `lua/kickstart/plugins/neo-tree.lua`, `lua/kickstart/plugins/mini.lua`, `lua/kickstart/plugins/tokyonight.lua`, `lua/kickstart/plugins/todo-comments.lua`, `lua/kickstart/plugins/indent_line.lua`

## Editing Tools

Productivity enhancements for faster, smarter editing.

### mini.nvim Suite

Collection of small, focused utilities:

**mini.ai** - Enhanced text objects:
- Better around/inside selections
- Works with (), {}, [], <>, quotes
- Next/last object support (e.g., `yinq` - yank inside next quote)

**mini.surround** - Manipulate surroundings:

- `saiw)` - Surround word with parentheses
- `sd'` - Delete surrounding quotes
- `sr)'` - Replace ) with '

**mini.comment** - Toggle comments:

- `gcc` - Toggle line comment
- `gc` (visual) - Toggle comment on selection
- `gcap` - Toggle comment on paragraph

### autopairs

Automatically closes brackets, quotes, parentheses as you type.

- Smart closing based on context
- Works with all bracket types
- Tree-sitter integration for accuracy

### guess-indent

Automatically detects and applies indentation style:

- Detects tabs vs spaces
- Determines indent width
- Applies settings per-file
- Respects .editorconfig if present

**Config:** `lua/kickstart/plugins/mini.lua`, `lua/kickstart/plugins/autopairs.lua`, `lua/lazy-plugins.lua`

## Architecture

### Component Interaction

```
┌─────────────────────────────────────────────────────────────┐
│                     Neovim Editor Core                      │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                    Plugin Manager (lazy.nvim)               │
│  • Lazy loading • Auto-installation • Lock file management │
└─────────────────────────────────────────────────────────────┘
        ↓               ↓                ↓              ↓
┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│ Language     │ │ Editing      │ │ Navigation   │ │ UI & Visual  │
│ Support      │ │ Enhancement  │ │ & Search     │ │ Enhancement  │
└──────────────┘ └──────────────┘ └──────────────┘ └──────────────┘
│              │ │              │ │              │ │              │
│ LSP          │ │ Completion   │ │ Telescope    │ │ which-key    │
│ Treesitter   │ │ Snippets     │ │ Fuzzy Find   │ │ Statusline   │
│ Formatters   │ │ Autopairs    │ │ File Tree    │ │ Theme        │
│ Linters      │ │ Surround     │ │ Treesitter   │ │ Indentation  │
│ Debugger     │ │ Comment      │ │ Navigation   │ │ TODO Highlight│
└──────────────┘ └──────────────┘ └──────────────┘ └──────────────┘
                         ↓
                  ┌──────────────┐
                  │ Git          │
                  │ Integration  │
                  │              │
                  │ gitsigns     │
                  │ fugitive     │
                  └──────────────┘
```

### Data Flow

```
User Types → Treesitter (parse) → LSP (analyze) → Completion (suggest)
                    ↓                  ↓                    ↓
              Highlighting      Diagnostics          Auto-import
                    ↓                  ↓                    ↓
           Textobject Selection   Linter Errors    Snippet Expansion
```

### Configuration Structure

```
lua/
├── options.lua          # Editor settings (numbers, clipboard, etc.)
├── keymaps.lua          # Core keybindings and autocommands
├── lazy-bootstrap.lua   # Plugin manager installation
├── lazy-plugins.lua     # Plugin list and lazy loading
└── kickstart/plugins/   # Modular plugin configurations
    ├── lspconfig.lua    # LSP servers and configuration
    ├── telescope.lua    # Fuzzy finder setup
    ├── treesitter.lua   # Syntax parsing and textobjects
    ├── blink-cmp.lua    # Completion engine
    ├── conform.lua      # Code formatting
    ├── lint.lua         # Code linting
    ├── gitsigns.lua     # Git change tracking
    ├── debug.lua        # Debugging support
    └── ...              # Other plugin configs (19 total)
```

## Performance Optimizations

This configuration includes several performance optimizations:

1. **Lazy loading**: Plugins load only when needed (events, commands, keys)
2. **Rust fuzzy matching**: blink.cmp uses compiled Rust for fast fuzzy search
3. **fd integration**: 2-3x faster file finding than traditional tools
4. **Telescope ignore patterns**: Skips irrelevant directories (.git/, node_modules/)
5. **fzf-native**: C-based fuzzy finding in Telescope
6. **Treesitter incremental parsing**: Only re-parses changed sections
7. **Swap file disabled for guess-indent**: Reduced disk I/O on file open

## Next Steps

- **Learn keybindings**: See [keybindings.md](keybindings.md) for complete reference
- **Explore plugins**: See [plugins.md](plugins.md) for detailed plugin information
- **Customize**: See [customization.md](customization.md) for how to extend
- **Master workflows**: See [workflows.md](workflows.md) for common development patterns
- **Plan ahead**: See [future.md](future.md) for potential enhancements
