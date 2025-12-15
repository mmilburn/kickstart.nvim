return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim' },
    },
    config = function()
      -- Optional: ensure asm-lsp is installed via Mason
      local ok_registry, registry = pcall(require, 'mason-registry')
      if ok_registry then
        local ok_pkg, pkg = pcall(registry.get_package, 'asm-lsp')
        if ok_pkg and not pkg:is_installed() then
          pkg:install()
        end
      end

      -- Root detection helper
      local util = require 'lspconfig.util'

      -- Define the server in Neovim core (NEW API)
      vim.lsp.config('asm_lsp', {
        cmd = { 'asm-lsp' },
        filetypes = { 'asm' },
        root_dir = util.root_pattern('.git', 'Makefile', 'main.asm', 'build.zig', 'CMakeLists.txt'),
      })

      -- Enable the server
      vim.lsp.enable 'asm_lsp'
    end,
  },
}
