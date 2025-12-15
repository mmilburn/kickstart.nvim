return {
  -- Ensure .asm / .inc are treated as "asm"
  {
    'nvim-neovim/nvim-lspconfig',
    init = function()
      vim.filetype.add {
        extension = {
          asm = 'asm',
          inc = 'asm',
        },
      }
    end,
  },
  -- Ensure Treesitter installs the asm parser
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      if type(opts.ensure_installed) == 'table' then
        table.insert(opts.ensure_installed, 'asm')
      end
    end,
  },
}
