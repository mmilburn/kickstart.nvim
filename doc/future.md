# Future Enhancements

Potential features and plugins to consider adding next, organized by category with rationale and implementation guidance.

## Table of Contents

- [Language Support Expansion](#language-support-expansion)
- [Testing Integration](#testing-integration)
- [Project Management](#project-management)
- [Enhanced Git Features](#enhanced-git-features)
- [Code Analysis](#code-analysis)
- [AI/Copilot Integration](#aicopilot-integration)
- [Terminal Integration](#terminal-integration)
- [Writing/Documentation](#writingdocumentation)
- [UI Enhancements](#ui-enhancements)
- [Performance Monitoring](#performance-monitoring)

---

## Language Support Expansion

### TypeScript/JavaScript LSP

**Problem:** No LSP support for TypeScript/JavaScript currently
**When Needed:** Working on web projects, React/Vue/Angular apps
**Complexity:** Easy

**Installation:**

```lua
-- In lua/kickstart/plugins/lspconfig.lua, add to servers:
servers = {
  -- ... existing ...
  ts_ls = {
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayFunctionParameterTypeHints = true,
        },
      },
    },
  },
}
```

**Also add formatter:**
```lua
-- In conform.lua
formatters_by_ft = {
  -- ... existing ...
  javascript = { 'prettier' },
  typescript = { 'prettier' },
  javascriptreact = { 'prettier' },
  typescriptreact = { 'prettier' },
}

-- Add to mason-tool-installer:
ensure_installed = { 'prettier', -- ... }
```

**Linter:**
```lua
-- In lint.lua
linters_by_ft = {
  javascript = { 'eslint' },
  typescript = { 'eslint' },
}
```

**Plugin:** Built-in LSP, no extra plugin needed

---

### Web Development (HTML/CSS/Tailwind)

**Problem:** No LSP for HTML/CSS
**When Needed:** Full-stack web development
**Complexity:** Easy

**Installation:**

```lua
-- HTML
html = {},

-- CSS
cssls = {},

-- Tailwind
tailwindcss = {
  filetypes = { 'html', 'css', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
},
```

**Plugin:** Built-in LSP

---

## Testing Integration

### neotest

**Repository:** [nvim-neotest/neotest](https://github.com/nvim-neotest/neotest)
**Problem:** No test runner integration
**When Needed:** Running tests from Neovim, seeing results inline
**Complexity:** Medium

**Features:**
- Run tests at cursor/file/suite level
- Show results inline with virtual text
- Test output in separate window
- Jump to failing tests
- Watch mode

**Installation:**

```lua
return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- Adapters for your languages:
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-go',
    'nvim-neotest/neotest-jest',  -- JavaScript/TypeScript
    'rcasia/neotest-java',
  },
  keys = {
    { '<leader>tn', function() require('neotest').run.run() end, desc = 'Run nearest test' },
    { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run file tests' },
    { '<leader>ts', function() require('neotest').summary.toggle() end, desc = 'Toggle test summary' },
    { '<leader>to', function() require('neotest').output.open() end, desc = 'Show test output' },
  },
  opts = function()
    return {
      adapters = {
        require('neotest-python'),
        require('neotest-go'),
        require('neotest-jest'),
        require('neotest-java'),
      },
    }
  end,
}
```

**Complexity:** Medium (requires language-specific adapters)

---

### nvim-coverage

**Repository:** [andythigpen/nvim-coverage](https://github.com/andythigpen/nvim-coverage)
**Problem:** No test coverage visualization
**When Needed:** Seeing which code is tested
**Complexity:** Easy

**Features:**
- Shows covered/uncovered lines
- Summary of coverage %
- Integrates with neotest

**Plugin:** [andythigpen/nvim-coverage](https://github.com/andythigpen/nvim-coverage)

---

## Project Management

### project.nvim

**Repository:** [ahmedkhalf/project.nvim](https://github.com/ahmedkhalf/project.nvim)
**Problem:** No quick project switching
**When Needed:** Working on multiple projects
**Complexity:** Easy

**Features:**
- Auto-detect projects (git repos)
- Quick switch between projects
- Recent projects list
- Telescope integration

**Installation:**

```lua
return {
  'ahmedkhalf/project.nvim',
  config = function()
    require('project_nvim').setup {}
    require('telescope').load_extension('projects')
  end,
  keys = {
    { '<leader>sp', '<cmd>Telescope projects<cr>', desc = 'Search Projects' },
  },
}
```

**Plugin:** [ahmedkhalf/project.nvim](https://github.com/ahmedkhalf/project.nvim)

---

### persistence.nvim

**Repository:** [folke/persistence.nvim](https://github.com/folke/persistence.nvim)
**Problem:** No session management
**When Needed:** Restore window layouts, open files
**Complexity:** Easy

**Features:**
- Auto-save sessions per directory
- Restore last session
- Minimal configuration

**Installation:**

```lua
return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {},
  keys = {
    { '<leader>qs', function() require('persistence').load() end, desc = 'Restore Session' },
    { '<leader>ql', function() require('persistence').load({ last = true }) end, desc = 'Restore Last Session' },
    { '<leader>qd', function() require('persistence').stop() end, desc = "Don't Save Session" },
  },
}
```

**Plugin:** [folke/persistence.nvim](https://github.com/folke/persistence.nvim)

---

## Enhanced Git Features

### git-messenger.vim

**Repository:** [rhysd/git-messenger.vim](https://github.com/rhysd/git-messenger.vim)
**Problem:** Inline blame only shows last commit
**When Needed:** Understanding commit history at cursor
**Complexity:** Easy

**Features:**
- Popup with full commit message
- Navigate through commit history
- Diff view

**Plugin:** [rhysd/git-messenger.vim](https://github.com/rhysd/git-messenger.vim)

---

### octo.nvim

**Repository:** [pwntester/octo.nvim](https://github.com/pwntester/octo.nvim)
**Problem:** No GitHub integration
**When Needed:** Creating PRs, reviewing code, managing issues
**Complexity:** Medium

**Features:**
- Create/edit issues and PRs
- Review code with comments
- Merge PRs
- All from Neovim

**Plugin:** [pwntester/octo.nvim](https://github.com/pwntester/octo.nvim)

---

## Code Analysis

### trouble.nvim

**Repository:** [folke/trouble.nvim](https://github.com/folke/trouble.nvim)
**Problem:** Default diagnostic list is basic
**When Needed:** Better view of errors/warnings
**Complexity:** Easy

**Features:**
- Pretty list of diagnostics
- LSP references/definitions list
- Quickfix/location list replacement
- Document symbols

**Installation:**

```lua
return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
    { '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics' },
    { '<leader>xl', '<cmd>Trouble lsp toggle<cr>', desc = 'LSP references/definitions' },
  },
  opts = {},
}
```

**Plugin:** [folke/trouble.nvim](https://github.com/folke/trouble.nvim)

---

### aerial.nvim

**Repository:** [stevearc/aerial.nvim](https://github.com/stevearc/aerial.nvim)
**Problem:** No persistent symbol outline
**When Needed:** Navigating large files
**Complexity:** Easy

**Features:**
- Symbol outline sidebar
- Navigate to symbols
- Treesitter + LSP support
- Icons for symbol types

**Plugin:** [stevearc/aerial.nvim](https://github.com/stevearc/aerial.nvim)

---

## AI/Copilot Integration

### GitHub Copilot

**Repository:** [github/copilot.vim](https://github.com/github/copilot.vim) or [zbirenbaum/copilot.lua](https://github.com/zbirenbaum/copilot.lua)
**Problem:** No AI-assisted code completion
**When Needed:** Faster coding with AI suggestions
**Complexity:** Medium (requires GitHub Copilot subscription)

**Features:**
- AI-powered code completions
- Multi-line suggestions
- Natural language to code

**Installation (copilot.lua):**

```lua
return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup({
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = '<M-l>',  -- Alt+l
          next = '<M-]>',
          prev = '<M-[>',
        },
      },
    })
  end,
}
```

**Plugin:** [zbirenbaum/copilot.lua](https://github.com/zbirenbaum/copilot.lua)
**Cost:** Requires GitHub Copilot subscription

---

### ChatGPT.nvim

**Repository:** [jackMort/ChatGPT.nvim](https://github.com/jackMort/ChatGPT.nvim)
**Problem:** No in-editor AI chat
**When Needed:** Code explanation, generation, refactoring with AI
**Complexity:** Medium (requires OpenAI API key)

**Features:**
- Chat with GPT in Neovim
- Code actions (explain, optimize, fix)
- Custom prompts

**Plugin:** [jackMort/ChatGPT.nvim](https://github.com/jackMort/ChatGPT.nvim)
**Cost:** Requires OpenAI API key

---

## Terminal Integration

### toggleterm.nvim

**Repository:** [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
**Problem:** Built-in terminal is basic
**When Needed:** Better terminal management, REPL
**Complexity:** Easy

**Features:**
- Multiple terminals
- Floating/split terminals
- Quick toggle
- Terminal-specific mappings

**Installation:**

```lua
return {
  'akinsho/toggleterm.nvim',
  keys = {
    { '<C-\\>', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' },
  },
  opts = {
    direction = 'float',  -- or 'horizontal', 'vertical'
    float_opts = {
      border = 'curved',
    },
  },
}
```

**Plugin:** [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)

---

### iron.nvim

**Repository:** [Vigemus/iron.nvim](https://github.com/Vigemus/iron.nvim)
**Problem:** No REPL integration
**When Needed:** Python/Julia/R interactive development
**Complexity:** Medium

**Features:**
- Send code to REPL
- Interactive development
- Multiple REPL support

**Plugin:** [Vigemus/iron.nvim](https://github.com/Vigemus/iron.nvim)

---

## Writing/Documentation

### markdown-preview.nvim

**Repository:** [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)
**Problem:** No Markdown preview
**When Needed:** Writing documentation, README files
**Complexity:** Easy

**Features:**
- Live preview in browser
- Sync scroll
- GitHub-flavored Markdown

**Installation:**

```lua
return {
  'iamcco/markdown-preview.nvim',
  ft = 'markdown',
  build = function()
    vim.fn['mkdp#util#install']()
  end,
  keys = {
    { '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Markdown Preview' },
  },
}
```

**Plugin:** [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)

---

## UI Enhancements

### bufferline.nvim

**Repository:** [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
**Problem:** No visual buffer tabs
**When Needed:** Working with many buffers
**Complexity:** Easy

**Features:**
- Tab-like buffer list
- Close buttons
- Buffer grouping
- Diagnostics indicators

**Plugin:** [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)

---

### alpha-nvim (Dashboard)

**Repository:** [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim)
**Problem:** No startup screen
**When Needed:** Pretty startup, quick access to recent files
**Complexity:** Easy

**Features:**
- Customizable startup screen
- Recent files
- Quick actions
- ASCII art

**Plugin:** [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim)

---

### Smooth Scrolling

**Repository:** [karb94/neoscroll.nvim](https://github.com/karb94/neoscroll.nvim)
**Problem:** Instant scrolling feels jarring
**When Needed:** Prefer smooth scrolling
**Complexity:** Easy

**Plugin:** [karb94/neoscroll.nvim](https://github.com/karb94/neoscroll.nvim)

---

## Performance Monitoring

### Startuptime Profiling

**Problem:** Need detailed startup analysis
**When Needed:** Debugging slow startup
**Complexity:** Easy

**Command:**

```bash
nvim --startuptime startup.log +q
cat startup.log
```

Shows detailed timing of every step.

**Plugin:** Built-in

---

## Implementation Priority

**High Priority (Easy Wins):**
1. TypeScript/JavaScript LSP + Prettier
2. trouble.nvim (better diagnostics)
3. markdown-preview.nvim
4. project.nvim (project switching)

**Medium Priority:**
5. neotest (test runner)
6. toggleterm.nvim (better terminal)
7. persistence.nvim (sessions)
8. bufferline.nvim (buffer tabs)

**Low Priority (Nice to Have):**
9. GitHub Copilot (requires subscription)
10. alpha-nvim (startup screen)
11. aerial.nvim (symbol outline)
12. ChatGPT.nvim (requires API key)

## Next Steps

1. **Identify your needs:** What languages/workflows are you using most?
2. **Start small:** Add one plugin at a time
3. **Test thoroughly:** Make sure it works before adding more
4. **Read docs:** Each plugin has unique configuration options
5. **Customize:** Adapt keybindings to your workflow

## Related Documentation

- [Customization](customization.md) - How to add these plugins
- [Plugins](plugins.md) - Current plugin catalog
- [Features](features.md) - Existing features
