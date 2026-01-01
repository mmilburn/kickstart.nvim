-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

---@module 'lazy'
---@type LazySpec
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    {
      '\\',
      function()
        local buf = vim.api.nvim_get_current_buf()
        local bufname = vim.api.nvim_buf_get_name(buf)
        local buftype = vim.bo[buf].buftype
        if buftype ~= '' or bufname == '' or bufname:match '^%w+://' then
          vim.cmd 'Neotree show'
          return
        end
        vim.cmd 'Neotree reveal'
      end,
      desc = 'NeoTree reveal',
      silent = true,
    },
  },
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = {
    close_if_last_window = true,
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['<space>'] = 'none',
        },
      },
    },
  },
}
