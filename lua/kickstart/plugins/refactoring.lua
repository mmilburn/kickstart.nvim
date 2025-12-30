return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    {
      '<leader>re',
      function()
        require('refactoring').refactor 'Extract Function'
      end,
      mode = 'x',
      desc = '[R]efactor [E]xtract Function',
    },
    {
      '<leader>rf',
      function()
        require('refactoring').refactor 'Extract Function To File'
      end,
      mode = 'x',
      desc = '[R]efactor Extract Function to [F]ile',
    },
    {
      '<leader>rv',
      function()
        require('refactoring').refactor 'Extract Variable'
      end,
      mode = 'x',
      desc = '[R]efactor Extract [V]ariable',
    },
    {
      '<leader>ri',
      function()
        require('refactoring').refactor 'Inline Variable'
      end,
      mode = { 'n', 'x' },
      desc = '[R]efactor [I]nline Variable',
    },
  },
  opts = {},
}
