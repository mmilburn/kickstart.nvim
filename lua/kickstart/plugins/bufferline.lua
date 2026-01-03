---@module 'lazy'
---@type LazySpec
return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/tokyonight.nvim' },
    event = 'VeryLazy',
    keys = {
      { '<leader>bp', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous [B]uffer' },
      { '<leader>bn', '<cmd>BufferLineCycleNext<cr>', desc = 'Next [B]uffer' },
      { '<leader>bP', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer left' },
      { '<leader>bN', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer right' },
      { '<leader>bc', '<cmd>BufferLinePickClose<cr>', desc = '[C]lose buffer (pick)' },
      { '<leader>bb', '<cmd>BufferLinePick<cr>', desc = 'Pick [B]uffer' },
      { '<leader>b1', '<cmd>BufferLineGoToBuffer 1<cr>', desc = 'Go to buffer 1' },
      { '<leader>b2', '<cmd>BufferLineGoToBuffer 2<cr>', desc = 'Go to buffer 2' },
      { '<leader>b3', '<cmd>BufferLineGoToBuffer 3<cr>', desc = 'Go to buffer 3' },
      { '<leader>b4', '<cmd>BufferLineGoToBuffer 4<cr>', desc = 'Go to buffer 4' },
      { '<leader>b5', '<cmd>BufferLineGoToBuffer 5<cr>', desc = 'Go to buffer 5' },
    },
    opts = {
      options = {
        mode = 'buffers', -- 'tabs' or 'buffers'
        numbers = 'ordinal', -- 'none', 'ordinal', 'buffer_id', 'both'
        close_command = 'bdelete! %d',
        right_mouse_command = 'bdelete! %d',
        left_mouse_command = 'buffer %d',
        middle_mouse_command = nil,

        -- Appearance
        indicator = {
          style = 'underline', -- 'icon', 'underline', 'none'
        },
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',

        -- Layout
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,

        -- Features
        diagnostics = 'nvim_lsp',
        diagnostics_update_on_event = true,
        diagnostics_indicator = function(count, level)
          local icon = level:match 'error' and ' ' or ' '
          return ' ' .. icon .. count
        end,

        offsets = {
          {
            filetype = 'neo-tree',
            text = 'File Explorer',
            text_align = 'center',
            separator = true,
          },
        },

        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        separator_style = 'slant', -- 'slant', 'padded_slant', 'slope', 'padded_slope', 'thick', 'thin'
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' },
        },
      },
    },
  },
}
