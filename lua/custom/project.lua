---@module 'lazy'
---@type LazySpec
return {
  'DrKJeff16/project.nvim',
  main = 'project',
  lazy = false,
  priority = 100,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    manual_mode = false,
  },
}
