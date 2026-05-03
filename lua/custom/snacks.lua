---@module 'lazy'
---@type LazySpec
return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      image = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
        style = 'compact',
      },
      quickfile = { enabled = true },
      terminal = {
        enabled = true,
        win = {
          keys = {
            nav_h = { '<C-h>', '<cmd>wincmd h<cr>', desc = 'Move to left window', mode = { 'n', 't' } },
            nav_j = { '<C-j>', '<cmd>wincmd j<cr>', desc = 'Move to lower window', mode = { 'n', 't' } },
            nav_k = { '<C-k>', '<cmd>wincmd k<cr>', desc = 'Move to upper window', mode = { 'n', 't' } },
            nav_l = { '<C-l>', '<cmd>wincmd l<cr>', desc = 'Move to right window', mode = { 'n', 't' } },
          },
        },
      },
      words = {
        enabled = true,
        -- Yield to LSP document_highlight when a client supports it; snacks.words
        -- is the fallback for buffers without semantic symbol resolution.
        filter = function(buf)
          for _, client in ipairs(vim.lsp.get_clients { bufnr = buf }) do
            if client:supports_method 'textDocument/documentHighlight' then
              return false
            end
          end
          return true
        end,
      },
    },
    keys = {
      {
        '<leader>nh',
        function()
          Snacks.notifier.show_history()
        end,
        desc = '[N]otification [H]istory',
      },
      {
        '<leader>nd',
        function()
          Snacks.notifier.hide()
        end,
        desc = '[N]otification [D]ismiss',
      },
      {
        '<leader>tt',
        function()
          Snacks.terminal.toggle(nil, { win = { position = 'bottom' } })
        end,
        desc = 'Toggle terminal',
        mode = { 'n', 't' },
      },
      {
        '<leader>tf',
        function()
          Snacks.terminal.toggle(nil, { win = { position = 'float' } })
        end,
        desc = 'Toggle [F]loating terminal',
      },
      {
        '<leader>tv',
        function()
          Snacks.terminal.toggle(nil, { win = { position = 'right' } })
        end,
        desc = 'Toggle [V]ertical terminal',
        mode = { 'n', 't' },
      },
    },
  },
}
