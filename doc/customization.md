# Customization Guide

Learn how to extend and customize this Neovim configuration for your needs.

## Table of Contents

- [Configuration Structure](#configuration-structure)
- [Common Customization Tasks](#common-customization-tasks)
- [Debugging Configuration](#debugging-configuration)
- [Best Practices](#best-practices)

## Configuration Structure

Understanding the file structure is key to customizing effectively.

```
/home/mark/.config/nvim/
├── init.lua                          # Entry point, loads everything
├── lua/
│   ├── options.lua                   # Editor settings (line numbers, clipboard, etc.)
│   ├── keymaps.lua                   # Core keybindings and autocommands
│   ├── lazy-bootstrap.lua            # Plugin manager installation
│   ├── lazy-plugins.lua              # Plugin list and lazy loading config
│   └── kickstart/plugins/            # Individual plugin configurations (19 files)
│       ├── lspconfig.lua             # LSP servers
│       ├── telescope.lua             # Fuzzy finder
│       ├── treesitter.lua            # Syntax highlighting
│       ├── blink-cmp.lua             # Completion
│       ├── conform.lua               # Formatters
│       ├── lint.lua                  # Linters
│       └── ...                       # Other plugins
└── lazy-lock.json                    # Plugin versions (keep in git)
```

### File Responsibilities

| File | Purpose | When to Edit |
|------|---------|--------------|
| `options.lua` | Editor behavior | Change UI, editing behavior |
| `keymaps.lua` | Core keybindings | Add global keybindings |
| `lazy-plugins.lua` | Plugin list | Add new simple plugins |
| `kickstart/plugins/*.lua` | Plugin configs | Configure specific plugins |

---

## Common Customization Tasks

### 1. Adding a New Plugin

#### Simple Plugin (No Configuration)

Add to `lua/lazy-plugins.lua`:

```lua
require('lazy').setup({
  -- ... existing plugins ...

  -- Add your plugin here
  'username/plugin-name',

  -- ... rest of plugins ...
}, { -- config })
```

#### Plugin with Configuration

Create a new file `lua/kickstart/plugins/my-plugin.lua`:

```lua
return {
  'username/plugin-name',
  event = 'VimEnter',  -- When to load (optional)
  dependencies = {
    'other/required-plugin',
  },
  opts = {
    -- Plugin configuration
    setting1 = true,
    setting2 = 'value',
  },
}
```

Then reference it in `lua/lazy-plugins.lua`:

```lua
require('lazy').setup({
  -- ... existing plugins ...

  require 'kickstart.plugins.my-plugin',

  -- ... rest of plugins ...
}, { -- config })
```

#### Lazy Loading Strategies

```lua
-- Load on specific event
{
  'plugin/name',
  event = 'VimEnter',  -- or 'BufReadPre', 'InsertEnter', etc.
}

-- Load on command
{
  'plugin/name',
  cmd = { 'PluginCommand', 'AnotherCommand' },
}

-- Load on keybinding
{
  'plugin/name',
  keys = {
    { '<leader>x', '<cmd>PluginCommand<cr>', desc = 'Description' },
  },
}

-- Load for specific filetypes
{
  'plugin/name',
  ft = { 'python', 'lua' },
}
```

**Example - Adding a Markdown Preview Plugin:**

```lua
-- Create lua/kickstart/plugins/markdown-preview.lua
return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = function()
    vim.fn['mkdp#util#install']()
  end,
  keys = {
    {
      '<leader>mp',
      '<cmd>MarkdownPreviewToggle<cr>',
      desc = '[M]arkdown [P]review',
      ft = 'markdown',
    },
  },
}
```

### 2. Adding a New Keybinding

#### Global Keybinding

Add to `lua/keymaps.lua`:

```lua
-- At the end of the file, before vim: comment
vim.keymap.set('n', '<leader>x', function()
  -- Your action here
  print('Hello from custom keybinding!')
end, { desc = 'Custom [X] action' })
```

#### Mode-Specific Keybinding

```lua
-- Normal mode
vim.keymap.set('n', '<leader>x', '<cmd>YourCommand<cr>', { desc = 'Description' })

-- Visual mode
vim.keymap.set('v', '<leader>x', '<cmd>YourCommand<cr>', { desc = 'Description' })

-- Insert mode
vim.keymap.set('i', '<C-s>', '<cmd>YourCommand<cr>', { desc = 'Description' })

-- Multiple modes
vim.keymap.set({ 'n', 'v' }, '<leader>x', '<cmd>YourCommand<cr>', { desc = 'Description' })
```

#### Plugin-Specific Keybinding

Add to the plugin's config file:

```lua
-- In lua/kickstart/plugins/my-plugin.lua
return {
  'plugin/name',
  keys = {
    {
      '<leader>x',
      function()
        require('plugin').action()
      end,
      desc = 'Plugin [X] action',
      mode = 'n',  -- optional, defaults to 'n'
    },
  },
}
```

**Example - Adding a Terminal Toggle:**

```lua
-- In lua/keymaps.lua
vim.keymap.set('n', '<leader>tt', function()
  vim.cmd.terminal()
end, { desc = '[T]oggle [T]erminal' })
```

### 3. Adding a New LSP Server

Edit `lua/kickstart/plugins/lspconfig.lua`:

```lua
-- Find the servers table (around line 205)
local servers = {
  -- ... existing servers ...

  -- Add your LSP server
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        cargo = {
          allFeatures = true,
        },
        checkOnSave = {
          command = 'clippy',
        },
      },
    },
  },

  -- TypeScript
  ts_ls = {},

  -- Python
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = 'basic',
        },
      },
    },
  },
}

-- If the server needs to be installed via Mason,
-- add it to ensure_installed (around line 235):
mason_lspconfig.setup {
  ensure_installed = {
    'lua_ls',
    'bashls',
    'rust_analyzer',  -- Add here
    'ts_ls',          -- Add here
    'pyright',        -- Add here
  },
}
```

**Finding LSP Server Names:**
- Visit: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
- Or run: `:Mason` and browse available servers

### 4. Adding a Formatter

Edit `lua/kickstart/plugins/conform.lua`:

```lua
-- Add to formatters_by_ft table (around line 34)
formatters_by_ft = {
  lua = { 'stylua' },
  python = { 'isort', 'black' },
  java = { 'google-java-format' },
  asm = { 'asmfmt' },

  -- Add your formatters
  rust = { 'rustfmt' },
  go = { 'gofmt', 'goimports' },  -- Sequential: gofmt then goimports
  javascript = { 'prettier' },
  typescript = { 'prettier' },
  html = { 'prettier' },
  css = { 'prettier' },
  json = { 'prettier' },
  markdown = { 'prettier' },
},
```

Then ensure the formatter is installed via Mason. Add to `lua/kickstart/plugins/lspconfig.lua`:

```lua
-- Find mason_tool_installer.setup (around line 253)
mason_tool_installer.setup {
  ensure_installed = {
    'stylua',
    'google-java-format',
    'black',
    'isort',
    'rustfmt',   -- Add your formatters here
    'gofmt',
    'goimports',
    'prettier',
  },
}
```

**Disable Format on Save for Specific Filetypes:**

```lua
-- In conform.lua format_on_save function (around line 24)
local disable_filetypes = { c = true, cpp = true, markdown = true }
```

### 5. Adding a Linter

Edit `lua/kickstart/plugins/lint.lua`:

```lua
-- Add to linters_by_ft table (around line 11)
linters_by_ft = {
  markdown = { 'markdownlint' },
  dockerfile = { 'hadolint' },
  python = { 'flake8' },
  shell = { 'shellcheck' },

  -- Add your linters
  javascript = { 'eslint' },
  typescript = { 'eslint' },
  lua = { 'selene' },
  rust = { 'clippy' },
},
```

### 6. Changing Theme/Colors

Edit `lua/kickstart/plugins/tokyonight.lua`:

```lua
opts = {
  -- Change style variant
  style = 'night',  -- Options: 'storm', 'moon', 'night', 'day'

  -- Disable transparency
  transparent = false,  -- Currently true

  -- Change terminal colors
  terminal_colors = true,

  -- Customize colors
  on_colors = function(colors)
    colors.bg = '#1a1b26'  -- Customize background
    colors.comment = '#565f89'  -- Customize comments
  end,

  -- Customize highlights
  on_highlights = function(hl, c)
    hl.CursorLine = {
      bg = c.bg_highlight,
    }
  end,
},
```

**Try a Different Theme:**

```lua
-- Replace tokyonight.lua content with:
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    flavour = 'mocha',  -- latte, frappe, macchiato, mocha
  },
  init = function()
    vim.cmd.colorscheme 'catppuccin'
  end,
}
```

### 7. Modifying Editor Options

Edit `lua/options.lua`:

```lua
-- Line numbers
vim.o.number = true          -- Absolute line numbers
vim.o.relativenumber = true  -- Relative line numbers

-- Disable relative numbers:
vim.o.relativenumber = false

-- Add column guide
vim.o.colorcolumn = '80'  -- Vertical line at column 80

-- Disable line wrapping
vim.o.wrap = false

-- Change tab settings (also detected by guess-indent)
vim.o.tabstop = 4        -- Tab width
vim.o.shiftwidth = 4     -- Indent width
vim.o.expandtab = true   -- Use spaces instead of tabs

-- Change scroll offset
vim.o.scrolloff = 999    -- Keep cursor centered

-- Disable mouse
vim.o.mouse = ''

-- Change update time (affects cursor hold, auto-save, etc.)
vim.o.updatetime = 250  -- Default is good

-- Case-sensitive search
vim.o.ignorecase = false
vim.o.smartcase = false

-- Spell checking
vim.o.spell = true
vim.o.spelllang = 'en_us'
```

### 8. Adding Treesitter Parsers

Edit `lua/kickstart/plugins/treesitter.lua`:

```lua
-- Add to ensure_installed (around line 11)
ensure_installed = {
  'asm', 'bash', 'c', 'diff', 'dockerfile', 'go', 'html',
  'java', 'json', 'lua', 'luadoc', 'markdown', 'markdown_inline',
  'python', 'query', 'rust', 'toml', 'vim', 'vimdoc', 'yaml',

  -- Add your languages
  'typescript',
  'tsx',
  'javascript',
  'css',
  'graphql',
  'prisma',
},
```

**Available parsers:** See `:TSInstallInfo` or https://github.com/nvim-treesitter/nvim-treesitter#supported-languages

### 9. Creating a New Plugin Config File

**Step 1:** Create the file

```bash
touch lua/kickstart/plugins/my-new-plugin.lua
```

**Step 2:** Add plugin configuration

```lua
-- lua/kickstart/plugins/my-new-plugin.lua
return {
  'username/plugin-name',
  -- Your configuration here
  opts = {},
}
```

**Step 3:** Reference in lazy-plugins.lua

```lua
-- lua/lazy-plugins.lua
require('lazy').setup({
  -- ... existing plugins ...

  require 'kickstart.plugins.my-new-plugin',

  -- ... rest ...
}, {})
```

### 10. Modifying Which-Key Groups

Edit `lua/kickstart/plugins/which-key.lua`:

```lua
-- Add to spec table (around line 64)
spec = {
  { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
  { '<leader>t', group = '[T]oggle' },
  { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
  { 'gr', group = 'LSP Actions', mode = { 'n' } },

  -- Add your custom groups
  { '<leader>d', group = '[D]atabase', mode = 'n' },
  { '<leader>m', group = '[M]arkdown', mode = 'n' },
  { '<leader>g', group = '[G]it', mode = 'n' },
},
```

### 11. Adding Custom Autocommands

Add to `lua/keymaps.lua`:

```lua
-- Auto-format on save for specific filetypes
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.go', '*.rs' },
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Disable auto-comment on new line
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove { 'r', 'o' }
  end,
})

-- Set specific settings for Python files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.opt_local.colorcolumn = '88'  -- Black's line length
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

-- Highlight on yank (already included, but here's the pattern)
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('my-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank { timeout = 200 }
  end,
})
```

### 12. Adding Debug Adapters

Edit `lua/kickstart/plugins/debug.lua`:

```lua
-- Add to mason_nvim_dap ensure_installed (around line 106)
mason_nvim_dap.setup {
  automatic_installation = true,
  handlers = {},
  ensure_installed = {
    'delve',
    'codelldb',
    'python',    -- Add debugpy for Python
    'node2',     -- Add for JavaScript/TypeScript
  },
}

-- Configure the adapter (after mason_nvim_dap.setup)
require('dap').adapters.python = {
  type = 'executable',
  command = 'python',
  args = { '-m', 'debugpy.adapter' },
}

require('dap').configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    pythonPath = function()
      return '/usr/bin/python'
    end,
  },
}
```

---

## Debugging Configuration

### Health Checks

Run built-in health checks to diagnose issues:

```vim
:checkhealth
```

**Specific health checks:**
```vim
:checkhealth vim.lsp         " LSP status
:checkhealth telescope       " Telescope status
:checkhealth nvim-treesitter " Treesitter status
```

### Common Commands for Debugging

| Command | Purpose |
|---------|---------|
| `:Lazy` | Check plugin status and updates |
| `:LspInfo` | Show attached LSP servers |
| `:LspLog` | View LSP communication log |
| `:Mason` | Manage LSP servers and tools |
| `:ConformInfo` | Show formatter status for current buffer |
| `:TSInstallInfo` | Show Treesitter parser status |
| `:messages` | View all Neovim messages |
| `:checkhealth` | Run diagnostic checks |

### Viewing Logs

```lua
-- LSP logs
:LspLog

-- All messages
:messages

-- Clear messages
:messages clear
```

### Testing Configuration Changes

1. **Reload Configuration:**
   ```vim
   :source $MYVIMRC
   ```
   Or restart Neovim.

2. **Test Specific Module:**
   ```lua
   :lua require('my-module').setup()
   ```

3. **Check if Plugin Loaded:**
   ```lua
   :lua print(vim.inspect(require('lazy').plugins()))
   ```

### Common Issues and Solutions

**LSP not attaching:**
1. Check `:LspInfo` to see if server is running
2. Ensure file type is correct (`:set filetype?`)
3. Check server is installed (`:Mason`)
4. View errors in `:LspLog`

**Formatter not working:**
1. Check `:ConformInfo` for current buffer
2. Ensure formatter is installed via Mason
3. Check file type mapping in conform.lua
4. Test manually: `:lua require('conform').format()`

**Keybinding not working:**
1. Check if it's defined: `:map <leader>x`
2. Look for conflicts: `:verbose map <leader>x`
3. Check which-key: `<leader>` and look for the binding

**Plugin not loading:**
1. Check `:Lazy` for errors
2. Verify plugin spec syntax
3. Check lazy loading conditions
4. Look for error in `:messages`

---

## Best Practices

### 1. Keep Plugin Configs Modular

✅ **Good:**
```lua
-- One plugin per file in kickstart/plugins/
-- lua/kickstart/plugins/my-plugin.lua
return {
  'plugin/name',
  opts = {},
}
```

❌ **Avoid:**
```lua
-- Putting everything in lazy-plugins.lua
-- Makes it hard to maintain
```

### 2. Use Descriptive Keybinding Descriptions

✅ **Good:**
```lua
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {
  desc = '[F]ind [F]iles'
})
```

❌ **Avoid:**
```lua
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
-- No description - won't show in which-key
```

### 3. Document Your Customizations

✅ **Good:**
```lua
-- Disable format on save for Go because we use goimports on save via autocmd
local disable_filetypes = { c = true, cpp = true, go = true }
```

❌ **Avoid:**
```lua
local disable_filetypes = { c = true, cpp = true, go = true }
-- No explanation why
```

### 4. Test Changes Incrementally

- Change one thing at a time
- Restart Neovim and test
- Commit to git if it works
- This makes it easy to revert problems

### 5. Keep lazy-lock.json in Version Control

```bash
git add lazy-lock.json
git commit -m "Update plugin versions"
```

This ensures reproducible plugin versions across machines.

### 6. Use `:checkhealth` Regularly

After major changes, run `:checkhealth` to catch issues early.

### 7. Lazy Load When Possible

Faster startup = better experience:

```lua
-- Load on event
event = 'VimEnter',

-- Load on command
cmd = 'MyCommand',

-- Load on keys
keys = { '<leader>x' },

-- Load on filetype
ft = { 'python', 'lua' },
```

### 8. Read Plugin Documentation

Before adding a plugin:
1. Read the GitHub README
2. Check `:help plugin-name` if available
3. Look at example configurations
4. Start with minimal config, add features incrementally

---

## Example: Complete Custom Plugin Setup

Here's a complete example adding a new feature (Trouble.nvim for better diagnostics):

**Step 1:** Create `lua/kickstart/plugins/trouble.lua`:

```lua
return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'Trouble',
  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xd',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>xl',
      '<cmd>Trouble lsp toggle<cr>',
      desc = 'LSP Definitions / references / ...',
    },
  },
  opts = {},
}
```

**Step 2:** Add to `lua/lazy-plugins.lua`:

```lua
require('lazy').setup({
  -- ... existing plugins ...

  require 'kickstart.plugins.trouble',

  -- ... rest ...
}, {})
```

**Step 3:** Add which-key group in `lua/kickstart/plugins/which-key.lua`:

```lua
spec = {
  -- ... existing groups ...
  { '<leader>x', group = 'Diagnostics (Trouble)' },
},
```

**Step 4:** Restart Neovim and test:
```vim
:Lazy sync
```
Then restart and use `<leader>xx`.

---

## Related Documentation

- [Features](features.md) - What each feature does
- [Plugins](plugins.md) - Complete plugin catalog
- [Keybindings](keybindings.md) - All keybindings
- [Workflows](workflows.md) - Common development patterns
- [Future](future.md) - Ideas for new plugins/features
