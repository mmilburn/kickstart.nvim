---@module 'lazy'
---@type LazySpec
return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      image = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
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
  },
}
