---@module 'lazy'
---@type LazySpec
return {
  'saecki/crates.nvim',
  event = { 'BufRead Cargo.toml' },
  config = function()
    require('crates').setup()
  end,
}
