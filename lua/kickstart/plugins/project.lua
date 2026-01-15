---@module 'lazy'
---@type LazySpec
return {
  'DrKJeff16/project.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    manual_mode = false,
  },
}
