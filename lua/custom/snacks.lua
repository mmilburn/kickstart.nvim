---@module 'lazy'
---@type LazySpec
return {
  {
    'folke/snacks.nvim',
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      image = { enabled = true },
      input = { enabled = true },
      quickfile = { enabled = true },
      words = { enabled = true },
    },
  },
}
