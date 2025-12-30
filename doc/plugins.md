# Plugin Catalog

Comprehensive reference for all 40+ plugins in this configuration.

## Table of Contents

- [Core Infrastructure](#core-infrastructure)
- [LSP & Language Support](#lsp--language-support)
- [Completion](#completion)
- [Fuzzy Finding](#fuzzy-finding)
- [Syntax & Parsing](#syntax--parsing)
- [Code Quality](#code-quality)
- [Git Integration](#git-integration)
- [Debugging](#debugging)
- [Editing Enhancements](#editing-enhancements)
- [UI & Visual](#ui--visual)
- [Plugin Summary Table](#plugin-summary-table)

---

## Core Infrastructure

### lazy.nvim
**Repository:** [folke/lazy.nvim](https://github.com/folke/lazy.nvim)
**Purpose:** Modern plugin manager with lazy loading and lock file support

**Key Features:**
- Lazy loading by events, commands, file types, or keybindings
- Lock file for reproducible installations (lazy-lock.json)
- Fast startup with parallel plugin loading
- Built-in profiling and benchmarking
- UI for managing plugins (`:Lazy`)

**Configuration Highlights:**
- Auto-installs if not present (bootstrap in lazy-bootstrap.lua)
- Custom UI icons based on Nerd Font availability
- All plugins configured to load only when needed

**Commands:**
- `:Lazy` - Open plugin manager UI
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Install missing and update plugins
- `:Lazy clean` - Remove unused plugins

**Config:** `lua/lazy-bootstrap.lua`, `lua/lazy-plugins.lua`

### plenary.nvim
**Repository:** [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
**Purpose:** Lua utility library required by many plugins

**Key Features:**
- Async operations
- Path manipulation
- Functional programming utilities
- Job control
- Window management helpers

**Used By:** Telescope, gitsigns, todo-comments, refactoring.nvim

**Config:** Dependency only, no configuration needed

### nui.nvim
**Repository:** [MunifTanjim/nui.nvim](https://github.com/MunifTanjim/nui.nvim)
**Purpose:** UI component library for building interfaces

**Key Features:**
- Popup windows
- Input fields
- Menus and selection lists
- Layout management

**Used By:** Neo-tree

**Config:** Dependency only, no configuration needed

### nvim-web-devicons
**Repository:** [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
**Purpose:** File type icons with Nerd Font support

**Key Features:**
- Icons for file types
- Color-coded by file extension
- Used throughout the UI

**Used By:** Telescope, Neo-tree, statusline

**Config:** Enabled based on Nerd Font availability

---

## LSP & Language Support

### nvim-lspconfig
**Repository:** [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
**Purpose:** Quickstart configs for Neovim LSP

**Key Features:**
- Pre-configured settings for language servers
- Automatic server setup
- Keybindings on LSP attach
- Diagnostic configuration
- Integration with completion

**Configured Servers:**
- `asm_lsp` - Assembly
- `bashls` - Bash
- `dockerls` - Docker
- `jdtls` - Java (via nvim-java)
- `lua_ls` - Lua
- `yamlls` - YAML with docker-compose schema

**Configuration Highlights:**
- Rounded diagnostic borders
- Severity sorting
- Virtual text with source info
- Document highlight on cursor hold
- Inlay hints support (toggle with `<leader>th`)

**Config:** `lua/kickstart/plugins/lspconfig.lua`

### mason.nvim
**Repository:** [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)
**Purpose:** Package manager for LSP servers, formatters, and linters

**Key Features:**
- Install LSP servers with one command
- Cross-platform support
- Automatic PATH setup
- UI for managing installations (`:Mason`)

**Commands:**
- `:Mason` - Open Mason UI
- `:MasonInstall <package>` - Install package
- `:MasonUninstall <package>` - Remove package

**Config:** `lua/kickstart/plugins/lspconfig.lua`

### mason-lspconfig.nvim
**Repository:** [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
**Purpose:** Bridge between mason and lspconfig

**Key Features:**
- Automatic server installation
- Integration with lspconfig setup
- Ensures servers are installed before use

**Config:** `lua/kickstart/plugins/lspconfig.lua`

### mason-tool-installer.nvim
**Repository:** [WhoIsSethDaniel/mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)
**Purpose:** Auto-install formatters and linters

**Key Features:**
- Installs tools on startup
- Configured list of required tools

**Auto-installed Tools:**
- `stylua` - Lua formatter
- `google-java-format` - Java formatter
- `black` - Python formatter
- `isort` - Python import sorter

**Config:** `lua/kickstart/plugins/lspconfig.lua`

### fidget.nvim
**Repository:** [j-hui/fidget.nvim](https://github.com/j-hui/fidget.nvim)
**Purpose:** LSP progress notifications

**Key Features:**
- Shows LSP indexing progress
- Non-intrusive notifications
- Integrates with status line

**Config:** `lua/kickstart/plugins/lspconfig.lua` (minimal config)

### lazydev.nvim
**Repository:** [folke/lazydev.nvim](https://github.com/folke/lazydev.nvim)
**Purpose:** Lua LSP for Neovim config development

**Key Features:**
- Completion for Neovim Lua APIs
- Type checking for vim functions
- Annotations and signatures
- Includes luv library types

**Configuration Highlights:**
- Loads only for Lua files
- Integrated with blink.cmp
- High priority in completion sources

**Config:** `lua/kickstart/plugins/lspconfig.lua`

### nvim-java
**Repository:** [nvim-java/nvim-java](https://github.com/nvim-java/nvim-java)
**Purpose:** Full-featured Java development support

**Key Features:**
- jdtls integration
- Spring Boot support
- Test runner integration
- Debugging with Java Debug Server
- Automatic project detection

**Configuration Highlights:**
- Auto-setup before LSP configuration
- Includes spring-boot.nvim dependency

**Config:** `lua/kickstart/plugins/nvim-java.lua`, `lua/kickstart/plugins/lspconfig.lua`

### spring-boot.nvim
**Repository:** [JavaHello/spring-boot.nvim](https://github.com/JavaHello/spring-boot.nvim)
**Purpose:** Spring Boot specific features for Neovim

**Key Features:**
- Spring Boot project support
- Integration with nvim-java

**Used By:** nvim-java

**Config:** `lua/kickstart/plugins/nvim-java.lua`

---

## Completion

### blink.cmp
**Repository:** [saghen/blink.cmp](https://github.com/Saghen/blink.cmp)
**Purpose:** Modern, fast completion engine

**Key Features:**
- LSP-powered completions with auto-import
- Rust fuzzy matcher for speed
- Multiple completion sources
- Signature help while typing
- Snippet expansion
- Context-aware filtering

**Completion Sources (in priority order):**
1. LSP - Language server completions
2. Path - File/directory paths
3. Snippets - LuaSnip snippets
4. lazydev - Neovim Lua API (boosted priority)
5. Buffer - Words from file (markdown/text only)

**Configuration Highlights:**
- Uses 'default' preset (`<C-y>` to accept)
- Rust fuzzy matching enabled (`prefer_rust_with_warning`)
- Buffer completions disabled in code files
- Manual documentation trigger
- friendly-snippets loaded

**Keybindings:**
- `<C-y>` - Accept completion
- `<C-n>` / `<C-p>` - Navigate
- `<C-space>` - Toggle documentation
- `<C-e>` - Close menu
- `<C-k>` - Toggle signature help

**Config:** `lua/kickstart/plugins/blink-cmp.lua`

### LuaSnip
**Repository:** [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)
**Purpose:** Snippet engine for code templates

**Key Features:**
- Snippet expansion and navigation
- VSCode-style snippet format
- Dynamic placeholders
- Choice nodes
- Regex transformations

**Configuration Highlights:**
- Integration with blink.cmp
- friendly-snippets loaded for pre-made templates

**Keybindings:**
- `<Tab>` / `<S-Tab>` - Navigate snippet placeholders

**Config:** `lua/kickstart/plugins/blink-cmp.lua`

### friendly-snippets
**Repository:** [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
**Purpose:** Collection of pre-made snippets for many languages

**Key Features:**
- Hundreds of snippets for common patterns
- Supports many languages
- VSCode-compatible format

**Languages Supported:** Python, Java, JavaScript, TypeScript, Lua, Go, Rust, C, C++, and many more

**Config:** `lua/kickstart/plugins/blink-cmp.lua`

---

## Fuzzy Finding

### telescope.nvim
**Repository:** [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
**Purpose:** Fuzzy finder for files, grep, LSP symbols, and more

**Key Features:**
- File finding with fd integration
- Live grep with ripgrep
- LSP symbol search
- Buffer switching
- Help tag search
- Git file search
- Extensible with many pickers

**Optimizations:**
- fd for file finding (2-3x faster)
- Smart ignore patterns (.git/, node_modules/, build/)
- fzf-native algorithm
- Hidden file support
- Truncated path display

**Configuration Highlights:**
- Custom ripgrep arguments for hidden files
- File ignore patterns for performance
- Buffers picker without preview (instant)

**All Pickers:** `:Telescope` to see full list

**Config:** `lua/kickstart/plugins/telescope.lua`

**Keybindings:** See [keybindings.md](keybindings.md#telescope-fuzzy-finder)

### telescope-fzf-native.nvim
**Repository:** [nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
**Purpose:** C-based fzf algorithm for Telescope

**Key Features:**
- Extremely fast fuzzy matching
- Compiled C extension
- Drop-in replacement for default sorter

**Configuration Highlights:**
- Auto-builds with make
- Loaded as Telescope extension

**Config:** `lua/kickstart/plugins/telescope.lua`

### telescope-ui-select.nvim
**Repository:** [nvim-telescope/telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim)
**Purpose:** Use Telescope for vim.ui.select()

**Key Features:**
- Replaces default select UI with Telescope
- Consistent interface for selections
- Dropdown theme

**Used For:** Code actions, LSP selections, etc.

**Config:** `lua/kickstart/plugins/telescope.lua`

---

## Syntax & Parsing

### nvim-treesitter
**Repository:** [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
**Purpose:** Advanced syntax highlighting via AST parsing

**Key Features:**
- Accurate syntax highlighting
- Incremental parsing (fast)
- Auto-install parsers
- Indentation support
- Code folding (not enabled)

**Installed Parsers:**
Assembly, Bash, C, Diff, Dockerfile, Go, HTML, Java, JSON, Lua, Markdown, Python, Query, Rust, TOML, Vim, YAML

**Configuration Highlights:**
- Auto-install enabled
- Incremental selection with `<C-s>`
- Ruby uses regex highlighting (compatibility)

**Config:** `lua/kickstart/plugins/treesitter.lua`

### nvim-treesitter-textobjects
**Repository:** [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
**Purpose:** Structure-aware text objects and navigation

**Key Features:**
- Function/class/parameter text objects
- Smart navigation between code structures
- Parameter swapping
- Lookahead to next object

**Text Objects:**
- `af` / `if` - Around/inside function
- `ac` / `ic` - Around/inside class
- `aa` / `ia` - Around/inside parameter

**Navigation:**
- `]f` / `[f` - Next/previous function
- `]C` / `[C` - Next/previous class (capital C to avoid git conflict)
- `]a` / `[a` - Next/previous parameter

**Swapping:**
- `<leader>a` / `<leader>A` - Swap parameters

**Config:** `lua/kickstart/plugins/treesitter.lua`

### nvim-treesitter-context
**Repository:** [nvim-treesitter/nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)
**Purpose:** Show code context at top of window

**Key Features:**
- Displays containing function/class
- Sticky header effect
- Configurable line count

**Configuration Highlights:**
- Max 3 lines of context

**Config:** `lua/kickstart/plugins/treesitter.lua`

---

## Code Quality

### conform.nvim
**Repository:** [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)
**Purpose:** Async code formatter with LSP fallback

**Key Features:**
- Format on save
- Multiple formatters per filetype
- Sequential formatter chaining
- LSP fallback when no formatter available
- Fast async formatting

**Configured Formatters:**
- **Lua:** stylua
- **Python:** isort + black (sequential)
- **Java:** google-java-format
- **Assembly:** asmfmt

**Configuration Highlights:**
- Format on save enabled (except C/C++)
- 500ms timeout
- LSP fallback for unconfigured languages
- Manual format with `<leader>f`

**Commands:**
- `:ConformInfo` - Show formatter status for current buffer

**Config:** `lua/kickstart/plugins/conform.lua`

### nvim-lint
**Repository:** [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint)
**Purpose:** Async linting with diagnostics integration

**Key Features:**
- Real-time linting
- Automatic linting on events
- Integration with Neovim diagnostics
- Multiple linters per filetype

**Configured Linters:**
- **Markdown:** markdownlint
- **Docker:** hadolint
- **Python:** flake8
- **Shell:** shellcheck

**Configuration Highlights:**
- Lints on buffer enter, save, and insert leave
- Only runs in modifiable buffers

**Config:** `lua/kickstart/plugins/lint.lua`

### refactoring.nvim
**Repository:** [ThePrimeagen/refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim)
**Purpose:** Treesitter-powered refactoring operations

**Key Features:**
- Extract function from selection
- Extract variable
- Inline variable
- Extract to separate file

**Configuration Highlights:**
- Lazy loads on keybinding
- Requires visual selection for most operations

**Keybindings:**
- `<leader>re` - Extract function
- `<leader>rf` - Extract to file
- `<leader>rv` - Extract variable
- `<leader>ri` - Inline variable

**Config:** `lua/kickstart/plugins/refactoring.lua`

---

## Git Integration

### gitsigns.nvim
**Repository:** [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
**Purpose:** Git decorations and hunk operations

**Key Features:**
- Sign column indicators for changes
- Hunk preview, staging, reset
- Inline blame
- Navigate between changes
- Visual hunk selection

**Configuration Highlights:**
- Custom signs (+, ~, _, ‾)
- Extensive keybindings for hunk operations
- Blame and diff integration

**Keybindings:**
- `]c` / `[c` - Navigate changes
- `<leader>hs` - Stage hunk
- `<leader>hp` - Preview hunk
- See full list in [keybindings.md](keybindings.md#git-operations)

**Config:** `lua/kickstart/plugins/gitsigns.lua`

### vim-fugitive
**Repository:** [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
**Purpose:** Full-featured Git wrapper

**Key Features:**
- Complete Git command interface
- Diff viewing in splits
- Commit creation
- Blame annotations
- Merge conflict resolution
- Git history browsing

**Configuration Highlights:**
- Lazy loads on Git commands
- Integration with GitHub (GBrowse)

**Common Commands:**
- `:Git` / `:G` - Run Git commands
- `:Git commit` - Create commit
- `:Gdiffsplit` - View diff
- `:Git blame` - Show blame

**Config:** `lua/kickstart/plugins/fugitive.lua`

---

## Debugging

### nvim-dap
**Repository:** [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)
**Purpose:** Debug Adapter Protocol client

**Key Features:**
- Breakpoint management
- Step execution
- Variable inspection
- REPL for expression evaluation
- Multi-language support

**Supported Languages:**
- Go (via nvim-dap-go)
- Java (via nvim-java)
- C/C++/Rust/Assembly (via codelldb)

**Keybindings:**
- `F5` - Continue/Start
- `F1/F2/F3` - Step into/over/out
- `<leader>b` - Toggle breakpoint
- `F7` - Toggle debug UI

**Config:** `lua/kickstart/plugins/debug.lua`

### nvim-dap-ui
**Repository:** [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
**Purpose:** Beautiful debug UI for nvim-dap

**Key Features:**
- Variables view
- Call stack
- Breakpoints list
- Watches
- REPL console
- Scopes

**Configuration Highlights:**
- Toggles with `F7`
- Auto-opens on debug start

**Config:** `lua/kickstart/plugins/debug.lua`

### nvim-dap-virtual-text
**Repository:** [theHamsta/nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)
**Purpose:** Show variable values inline during debugging

**Key Features:**
- Virtual text display of values
- Treesitter integration
- Customizable display

**Config:** `lua/kickstart/plugins/debug.lua`

### nvim-dap-go
**Repository:** [leoluz/nvim-dap-go](https://github.com/leoluz/nvim-dap-go)
**Purpose:** Go debugging configuration for nvim-dap

**Key Features:**
- Delve debugger setup
- Test debugging
- Auto-configuration

**Config:** `lua/kickstart/plugins/debug.lua`

### mason-nvim-dap.nvim
**Repository:** [jay-babu/mason-nvim-dap.nvim](https://github.com/jay-babu/mason-nvim-dap.nvim)
**Purpose:** Mason integration for debug adapters

**Key Features:**
- Auto-install debug adapters
- Integration with Mason
- Adapter configuration

**Installed Adapters:**
- delve (Go)
- codelldb (C/C++/Rust/Assembly)
- java-debug-adapter
- java-test

**Config:** `lua/kickstart/plugins/debug.lua`

### nvim-nio
**Repository:** [nvim-neotest/nvim-nio](https://github.com/nvim-neotest/nvim-nio)
**Purpose:** Async I/O library for Neovim

**Key Features:**
- Required dependency for nvim-dap-ui
- Async operations

**Config:** Dependency only

---

## Editing Enhancements

### mini.nvim
**Repository:** [echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim)
**Purpose:** Collection of minimal, independent modules

**Enabled Modules:**

**mini.ai** - Enhanced text objects:
- Better around/inside selections
- Next/last object support
- Searches 500 lines

**mini.surround** - Manipulate surroundings:
- Add, delete, replace surrounding chars
- Works with (), {}, [], <>, quotes, tags

**mini.comment** - Toggle comments:
- Line and block comments
- Language-aware
- Treesitter integration

**mini.statusline** - Minimal statusline:
- Mode indicator
- File info
- Git branch
- Diagnostics
- Position

**Configuration Highlights:**
- Simple, fast implementations
- No external dependencies
- Sensible defaults

**Config:** `lua/kickstart/plugins/mini.lua`

### nvim-autopairs
**Repository:** [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)
**Purpose:** Auto-close brackets and quotes

**Key Features:**
- Smart bracket closing
- Treesitter integration
- Works with all bracket types
- Context-aware

**Config:** `lua/kickstart/plugins/autopairs.lua`

### guess-indent.nvim
**Repository:** [NMAC427/guess-indent.nvim](https://github.com/NMAC427/guess-indent.nvim)
**Purpose:** Auto-detect indentation style

**Key Features:**
- Detects tabs vs spaces
- Determines indent width
- Per-file configuration
- Respects .editorconfig

**Configuration Highlights:**
- Lazy loads on buffer read
- Automatic detection

**Config:** `lua/lazy-plugins.lua`

---

## UI & Visual

### which-key.nvim
**Repository:** [folke/which-key.nvim](https://github.com/folke/which-key.nvim)
**Purpose:** Display available keybindings

**Key Features:**
- Popup showing pending keybinds
- Grouped by category
- Icons for mappings
- Zero delay display

**Configured Groups:**
- `<leader>s` - Search
- `<leader>t` - Toggle
- `<leader>h` - Git Hunk
- `gr` - LSP Actions

**Configuration Highlights:**
- 0ms delay (instant display)
- Nerd Font icons
- Custom group descriptions

**Config:** `lua/kickstart/plugins/which-key.lua`

### neo-tree.nvim
**Repository:** [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
**Purpose:** File explorer tree view

**Key Features:**
- Visual directory tree
- Git integration
- File operations (create, delete, rename, etc.)
- Buffer and git status views
- Icons and colors

**Configuration Highlights:**
- Toggle with `\`
- Reveals current file in tree

**Commands:**
- `:Neotree` - Open file explorer
- `:Neotree reveal` - Show current file in tree

**Config:** `lua/kickstart/plugins/neo-tree.lua`

### tokyonight.nvim
**Repository:** [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
**Purpose:** Clean, dark color scheme

**Key Features:**
- Multiple style variants
- Transparent background support
- Treesitter highlighting
- LSP semantic tokens
- Terminal colors

**Configuration Highlights:**
- Uses 'night' variant
- Transparency enabled
- Italic comments

**Config:** `lua/kickstart/plugins/tokyonight.lua`

### todo-comments.nvim
**Repository:** [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
**Purpose:** Highlight TODO, FIXME, NOTE in comments

**Key Features:**
- Distinct colors for keywords
- Telescope integration
- Search all TODOs
- Configurable keywords

**Highlighted Keywords:**
- TODO
- FIXME
- HACK
- WARN
- PERF
- NOTE
- TEST

**Configuration Highlights:**
- Signs disabled (less visual clutter)

**Config:** `lua/kickstart/plugins/todo-comments.lua`

### indent-blankline.nvim
**Repository:** [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
**Purpose:** Indentation guides

**Key Features:**
- Visual indentation lines
- Scope highlighting
- Works on blank lines
- Treesitter integration

**Configuration Highlights:**
- Default configuration

**Config:** `lua/kickstart/plugins/indent_line.lua`

---

## Plugin Summary Table

| Plugin | Category | Load Strategy | Config File |
|--------|----------|---------------|-------------|
| lazy.nvim | Core | Immediate | lazy-bootstrap.lua |
| plenary.nvim | Core | Dependency | - |
| nui.nvim | Core | Dependency | - |
| nvim-web-devicons | Core | Dependency | - |
| nvim-lspconfig | LSP | On filetype | lspconfig.lua |
| mason.nvim | LSP | On lspconfig | lspconfig.lua |
| mason-lspconfig.nvim | LSP | Dependency | lspconfig.lua |
| mason-tool-installer.nvim | LSP | Dependency | lspconfig.lua |
| fidget.nvim | LSP | Dependency | lspconfig.lua |
| lazydev.nvim | LSP | On Lua files | lspconfig.lua |
| nvim-java | LSP | Dependency | nvim-java.lua |
| spring-boot.nvim | LSP | Dependency | nvim-java.lua |
| blink.cmp | Completion | On VimEnter | blink-cmp.lua |
| LuaSnip | Completion | Dependency | blink-cmp.lua |
| friendly-snippets | Completion | Dependency | blink-cmp.lua |
| telescope.nvim | Fuzzy Find | On VimEnter | telescope.lua |
| telescope-fzf-native.nvim | Fuzzy Find | Dependency | telescope.lua |
| telescope-ui-select.nvim | Fuzzy Find | Dependency | telescope.lua |
| nvim-treesitter | Syntax | On VimEnter | treesitter.lua |
| nvim-treesitter-textobjects | Syntax | Dependency | treesitter.lua |
| nvim-treesitter-context | Syntax | Dependency | treesitter.lua |
| conform.nvim | Code Quality | On BufWritePre/keys | conform.lua |
| nvim-lint | Code Quality | On BufReadPre | lint.lua |
| refactoring.nvim | Code Quality | On keys | refactoring.lua |
| gitsigns.nvim | Git | Auto | gitsigns.lua |
| vim-fugitive | Git | On command | fugitive.lua |
| nvim-dap | Debug | On keys | debug.lua |
| nvim-dap-ui | Debug | Dependency | debug.lua |
| nvim-dap-virtual-text | Debug | Dependency | debug.lua |
| nvim-dap-go | Debug | Dependency | debug.lua |
| mason-nvim-dap.nvim | Debug | Dependency | debug.lua |
| nvim-nio | Debug | Dependency | debug.lua |
| mini.nvim | Editing | Auto | mini.lua |
| nvim-autopairs | Editing | Auto | autopairs.lua |
| guess-indent.nvim | Editing | On BufReadPre | lazy-plugins.lua |
| which-key.nvim | UI | On VimEnter | which-key.lua |
| neo-tree.nvim | UI | On key | neo-tree.lua |
| tokyonight.nvim | UI | Priority load | tokyonight.lua |
| todo-comments.nvim | UI | On VimEnter | todo-comments.lua |
| indent-blankline.nvim | UI | Auto | indent_line.lua |

**Total:** 40 plugins

---

## Related Documentation

- [Features](features.md) - Feature overview and capabilities
- [Keybindings](keybindings.md) - Complete keybinding reference
- [Customization](customization.md) - How to add/modify plugins
- [Future Enhancements](future.md) - Potential plugins to add
