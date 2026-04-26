return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    ---@module 'nvim-treesitter'
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      ensure_installed = {
        'asm',
        'bash',
        'c',
        'cpp',
        'css',
        'diff',
        'dockerfile',
        'go',
        'html',
        'java',
        'json',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'rust',
        'toml',
        'typescript',
        'tsx',
        'vim',
        'vimdoc',
        'yaml',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby', 'java' },
      },
      indent = { enable = true, disable = { 'ruby', 'java' } },
      -- Incremental selection based on syntax tree
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-s>',
          node_incremental = '<C-s>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  { -- Show code context at top of window
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      max_lines = 3, -- How many lines of context to show
    },
  },
  { -- Treesitter textobjects for advanced text operations
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = { lookahead = true },
        move = { set_jumps = true },
      }

      -- Select
      local select = require 'nvim-treesitter-textobjects.select'
      local keymaps = {
        af = '@function.outer',
        ['if'] = '@function.inner',
        ac = '@class.outer',
        ic = '@class.inner',
        aa = '@parameter.outer',
        ia = '@parameter.inner',
      }
      for key, query in pairs(keymaps) do
        vim.keymap.set({ 'x', 'o' }, key, function()
          select.select_textobject(query, 'textobjects')
        end)
      end

      -- Move
      local move = require 'nvim-treesitter-textobjects.move'
      vim.keymap.set({ 'n', 'x', 'o' }, ']f', function() move.goto_next_start('@function.outer', 'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, ']C', function() move.goto_next_start('@class.outer', 'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, ']a', function() move.goto_next_start('@parameter.inner', 'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[f', function() move.goto_previous_start('@function.outer', 'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[C', function() move.goto_previous_start('@class.outer', 'textobjects') end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[a', function() move.goto_previous_start('@parameter.inner', 'textobjects') end)

      -- Swap
      local swap = require 'nvim-treesitter-textobjects.swap'
      vim.keymap.set('n', '<leader>a', function() swap.swap_next '@parameter.inner' end)
      vim.keymap.set('n', '<leader>A', function() swap.swap_previous '@parameter.inner' end)
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
