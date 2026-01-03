return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      direction = 'horizontal',
      start_in_insert = true, -- Auto enter insert mode when opening
      close_on_exit = true, -- Close window when process exits
      auto_scroll = true, -- Auto scroll to bottom on output
    },
    keys = {
      { '<leader>tt', '<cmd>ToggleTerm<cr>', desc = 'Toggle terminal', mode = { 'n', 't' } },
      { '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', desc = 'Toggle [F]loating terminal' },
      { '<leader>tv', '<cmd>ToggleTerm direction=vertical<cr>', desc = 'Toggle [V]ertical terminal', mode = { 'n', 't' } },
      -- Terminal navigation
      { '<C-h>', '<cmd>wincmd h<cr>', desc = 'Move to left window', mode = 't' },
      { '<C-j>', '<cmd>wincmd j<cr>', desc = 'Move to lower window', mode = 't' },
      { '<C-k>', '<cmd>wincmd k<cr>', desc = 'Move to upper window', mode = 't' },
      { '<C-l>', '<cmd>wincmd l<cr>', desc = 'Move to right window', mode = 't' },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
