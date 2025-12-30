# Neovim Configuration

A well-configured, performant Neovim setup based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), optimized for multi-language development with LSP, debugging, and Git integration.

```
┌─────────────────────────────────────────────────────────┐
│  📝 Modern Neovim IDE                                   │
│  ⚡ 40+ plugins • Lazy loading • Fast startup          │
│  🔧 LSP • DAP • Treesitter • Fuzzy Finding             │
│  🎨 Tokyonight • Transparent • Clean UI                 │
└─────────────────────────────────────────────────────────┘
```

## ✨ Features at a Glance

- **🔧 Language Support:** Assembly, Bash, Docker, Go, Java (Spring Boot), Lua, Markdown, Python, Rust, YAML
- **💡 LSP Integration:** Auto-install, format-on-save, diagnostics, inlay hints, auto-import
- **🎯 Completion:** blink.cmp with Rust fuzzy matching, snippets, signature help
- **🔍 Fuzzy Finding:** Telescope with fd and fzf-native for blazing-fast searches
- **🌳 Treesitter:** Syntax highlighting, textobjects, incremental selection
- **🐛 Debugging:** DAP with UI for Go, Java, C/C++/Rust/Assembly
- **📦 Git Integration:** gitsigns + fugitive for complete Git workflow
- **✂️ Refactoring:** Extract function/variable, inline, parameter swapping
- **🎨 Modern UI:** which-key, neo-tree, todo-comments, statusline

## 📋 Prerequisites

### Required

- **Neovim ≥ 0.10.0**
- **Git**
- **C Compiler** (gcc or clang) - for Treesitter and telescope-fzf-native
- **[ripgrep](https://github.com/BurntSushi/ripgrep)** - for live grep
- **[fd](https://github.com/sharkdp/fd)** - for fast file finding

### Recommended

- **[Nerd Font](https://www.nerdfonts.com/)** - for icons (Hack Nerd Font, JetBrainsMono Nerd Font, etc.)
- **Node.js** - for some language servers
- **Python 3** - for Python development

### Language-Specific

- **Java:** JDK 11+
- **Go:** Go toolchain
- **Rust:** Rust toolchain
- **Assembly:** NASM or similar

## 🚀 Installation

### Linux/macOS

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# Clone this repository
git clone <your-repo-url> ~/.config/nvim

# Install dependencies (Arch Linux)
sudo pacman -S ripgrep fd

# Or Ubuntu/Debian
sudo apt install ripgrep fd-find

# Or macOS
brew install ripgrep fd

# Start Neovim
nvim
```

### First Launch

On first launch, Neovim will:
1. Install lazy.nvim plugin manager
2. Download and install all plugins
3. Install Treesitter parsers
4. Install LSP servers via Mason

This takes 1-2 minutes. Progress is shown in the bottom-right corner.

## 📚 Documentation

Comprehensive documentation is available in the `doc/` directory:

| Document | Description |
|----------|-------------|
| **[Features](doc/features.md)** | Complete feature overview and capabilities |
| **[Keybindings](doc/keybindings.md)** | Full keybinding reference with tables |
| **[Plugins](doc/plugins.md)** | Catalog of all 40 plugins with configuration details |
| **[Customization](doc/customization.md)** | How to extend and modify the configuration |
| **[Workflows](doc/workflows.md)** | Common development workflows and patterns |
| **[Future Enhancements](doc/future.md)** | Potential plugins and features to add |

### Quick Links

- **Getting started?** Read [Features](doc/features.md) for an overview
- **Forgot a keybinding?** Check [Keybindings](doc/keybindings.md)
- **Want to customize?** See [Customization](doc/customization.md)
- **Learning workflows?** Browse [Workflows](doc/workflows.md)

## ⌨️ Essential Keybindings

**Leader key:** `Space`

| Category | Key | Action |
|----------|-----|--------|
| **File Navigation** | `<leader>sf` | Find files |
| | `<leader>sg` | Live grep |
| | `<leader><leader>` | Switch buffers |
| | `\` | Toggle file tree |
| **LSP** | `K` | Hover documentation |
| | `grd` | Go to definition |
| | `grr` | Find references |
| | `grn` | Rename symbol |
| | `gra` | Code action |
| **Git** | `]c` / `[c` | Next/prev change |
| | `<leader>hp` | Preview hunk |
| | `<leader>hs` | Stage hunk |
| **Completion** | `<C-y>` | Accept completion |
| | `<C-n>` / `<C-p>` | Navigate suggestions |
| **Debug** | `F5` | Start/Continue |
| | `F1/F2/F3` | Step into/over/out |
| | `<leader>b` | Toggle breakpoint |
| **Editing** | `gcc` | Toggle line comment |
| | `<leader>f` | Format buffer |
| | `<leader>re` | Extract function (visual) |

**Full list:** See [Keybindings](doc/keybindings.md)

## 🏗️ Configuration Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── options.lua            # Editor settings
│   ├── keymaps.lua            # Core keybindings
│   ├── lazy-bootstrap.lua     # Plugin manager setup
│   ├── lazy-plugins.lua       # Plugin list
│   └── kickstart/plugins/     # Individual plugin configs (19 files)
│       ├── lspconfig.lua      # LSP configuration
│       ├── telescope.lua      # Fuzzy finder
│       ├── treesitter.lua     # Syntax highlighting
│       ├── blink-cmp.lua      # Completion
│       ├── conform.lua        # Formatters
│       ├── lint.lua           # Linters
│       ├── gitsigns.lua       # Git integration
│       ├── debug.lua          # Debugging
│       └── ...                # And more
└── doc/                      # Documentation
    ├── features.md
    ├── keybindings.md
    ├── plugins.md
    ├── customization.md
    ├── workflows.md
    └── future.md
```

## 🎯 Language Support

| Language   | LSP | Formatter | Linter | Debugger | Notes |
|------------|-----|-----------|--------|----------|-------|
| Assembly   | ✓   | ✓         | -      | ✓        | asm_lsp + asmfmt + codelldb |
| Bash       | ✓   | -         | ✓      | -        | bashls + shellcheck |
| Docker     | ✓   | -         | ✓      | -        | dockerls + hadolint |
| Go         | -   | -         | -      | ✓        | Parser + delve debugger |
| Java       | ✓   | ✓         | -      | ✓        | jdtls + Spring Boot support |
| Lua        | ✓   | ✓         | -      | -        | lua_ls + stylua |
| Markdown   | -   | -         | ✓      | -        | markdownlint |
| Python     | -   | ✓         | ✓      | -        | black + isort + flake8 |
| Rust       | -   | -         | -      | ✓        | Parser + codelldb debugger |
| YAML       | ✓   | -         | -      | -        | yamlls + docker-compose schemas |

**Want to add more?** See [Future Enhancements](doc/future.md) for TypeScript, web development, and more.

## 🛠️ Common Tasks

### Update Plugins

```vim
:Lazy update
```

### Install New LSP Server

```vim
:Mason
# Navigate and press 'i' to install
```

### Check Health

```vim
:checkhealth
```

### View LSP Status

```vim
:LspInfo
```

### Format Current File

```
<leader>f
```

## 🔧 Customization

This configuration is designed to be extended. See [Customization](doc/customization.md) for detailed guides on:

- Adding new plugins
- Adding LSP servers
- Creating custom keybindings
- Configuring formatters and linters
- Modifying the theme
- And much more

**Quick example - Adding a new plugin:**

1. Create `lua/kickstart/plugins/my-plugin.lua`:
```lua
return {
  'username/plugin-name',
  opts = {},
}
```

2. Reference it in `lua/lazy-plugins.lua`:
```lua
require 'kickstart.plugins.my-plugin',
```

3. Restart Neovim

## 🎨 Theme

**Tokyonight Night** with transparency enabled.

Change theme in `lua/kickstart/plugins/tokyonight.lua`:
```lua
opts = {
  style = 'night',  -- or 'storm', 'moon', 'day'
  transparent = true,
}
```

Try different themes by replacing tokyonight.lua with your preferred theme plugin.

## ⚡ Performance

This configuration is optimized for fast startup:

- **Lazy loading:** Plugins load only when needed
- **Rust fuzzy matching:** blink.cmp uses compiled Rust for speed
- **fd integration:** 2-3x faster file finding
- **Optimized ignore patterns:** Skips .git/, node_modules/, build/
- **fzf-native:** C-based fuzzy finding

**Typical startup time:** 20-40ms with all plugins installed

**Profile startup:**
```bash
nvim --startuptime startup.log +q && cat startup.log
```

## 🐛 Troubleshooting

### LSP Not Working

```vim
:LspInfo              " Check if LSP is attached
:LspLog               " View LSP logs
:Mason                " Verify server is installed
:checkhealth vim.lsp  " Run LSP health check
```

### Completions Not Appearing

```vim
:lua print(vim.inspect(require('blink.cmp').config))  " Check config
:messages             " Look for errors
```

### Treesitter Issues

```vim
:TSInstallInfo        " Check parser status
:TSUpdate             " Update parsers
:checkhealth nvim-treesitter
```

### General Issues

```vim
:checkhealth          " Run all health checks
:Lazy                 " Check plugin status
:messages             " View error messages
```

## 📄 License

MIT License - see [LICENSE.md](LICENSE.md)

## Credits

Derived from the following:

- **[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)** - The foundation
- **[kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)** - Modular structure inspiration

## 📖 Learning Resources

- **Neovim docs:** `:help` in Neovim
- **Plugin docs:** `:help plugin-name` for most plugins
- **Telescope help:** `<leader>sh` to search help tags
- **LSP guide:** `:help lsp`
- **Lua guide:** `:help lua-guide`

## 🚦 Project Status

**Status:** ✅ Actively maintained

**Neovim Version:** Tested with Neovim 0.10+
**Plugin Count:** 40 plugins
**Last Updated:** See recent commits

---

**Quick Start:**
1. Install prerequisites (Neovim, ripgrep, fd)
2. Clone this repo to `~/.config/nvim`
3. Run `nvim` and wait for setup
4. Read [Features](doc/features.md) to learn what's available
5. Check [Keybindings](doc/keybindings.md) for shortcuts
