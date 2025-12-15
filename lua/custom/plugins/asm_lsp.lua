return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim' },
    },
    config = function()
      local ok_registry, registry = pcall(require, 'mason-registry')
      if ok_registry then
        local ok_pkg, pkg = pcall(registry.get_package, 'asm-lsp')
        if ok_pkg and not pkg:is_installed() then
          pkg:install()
        end
      end

      local lspconfig = require 'lspconfig'
      local util = lspconfig.util

      lspconfig.asm_lsp.setup {
        cmd = { 'asm-lsp' },
        filetypes = { 'asm' },
        root_dir = util.root_pattern('.git', 'Makefile', 'main.asm', 'build.zig', 'CMakeLists.txt'),
      }
    end,
  },
}
