return {
  {
    -- Kickstart already includes DAP via `require 'kickstart.plugins.debug'`
    -- This file only *extends* it with codelldb + an "asm" launch config + keymaps.
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text',
      'jay-babu/mason-nvim-dap.nvim',
      { 'mason-org/mason.nvim' },
    },
    config = function()
      local dap = require 'dap'

      -- Optional: install/ensure CodeLLDB via Mason DAP
      require('mason-nvim-dap').setup {
        automatic_setup = true,
        ensure_installed = { 'codelldb' },
      }

      -- A sane default: expects your build output at ./build/main
      dap.configurations.asm = {
        {
          name = 'Launch (CodeLLDB)',
          type = 'codelldb',
          request = 'launch',
          program = function()
            local default = vim.fn.getcwd() .. '/build/main'
            return vim.fn.input('Path to executable: ', default, 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
      }

      -- IDE-like keymaps
      vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'DAP: Step Over' })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'DAP: Step Into' })
      vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'DAP: Step Out' })
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'DAP: Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'DAP: REPL' })
      vim.keymap.set('n', '<leader>du', function()
        require('dapui').toggle()
      end, { desc = 'DAP UI: Toggle' })

      -- Build-before-debug on F5 (expects a Makefile; adjust if you use another build system)
      vim.keymap.set('n', '<F5>', function()
        local out = vim.fn.system { 'make', '-j' }
        if vim.v.shell_error ~= 0 then
          vim.notify('Build failed; not starting debugger.\n\n' .. out, vim.log.levels.ERROR)
          return
        end
        dap.continue()
      end, { desc = 'DAP: Build + Continue' })
    end,
  },
}
