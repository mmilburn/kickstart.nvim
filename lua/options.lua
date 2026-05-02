-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.termguicolors = true

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- Treat camelCase as word boundaries in spell checking.
vim.opt.spelloptions:append 'camel'

-- Disable line wrapping
-- vim.o.wrap = false

-- Highlight max chars per line
-- vim.o.colorcolumn = '120'

local function enable_spell()
  vim.opt_local.spell = true
  vim.opt_local.spelllang = 'en_us'
end

local spell_augroup = vim.api.nvim_create_augroup('spell_options', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = spell_augroup,
  pattern = { 'asciidoc', 'gitcommit', 'gitrebase', 'NeogitCommitMessage', 'jj', 'jjdescription', 'mail', 'markdown', 'text' },
  callback = enable_spell,
})

vim.api.nvim_create_autocmd('FileType', {
  group = spell_augroup,
  callback = function(args)
    if vim.bo[args.buf].buftype ~= '' then
      return
    end

    local ft = vim.bo[args.buf].filetype
    local ok, query = pcall(vim.treesitter.query.get, ft, 'spell')
    if ok and query ~= nil then
      enable_spell()
    end
  end,
})

local function set_bufferline_separator_variants()
  local function hl(name)
    return vim.api.nvim_get_hl(0, { name = name, link = false })
  end

  local tabline = hl 'TabLine'
  local status = hl 'StatusLine'
  local normal = hl 'Normal'

  local bg = tabline.bg or status.bg or normal.bg
  local fg = tabline.fg or normal.fg

  if not bg then
    -- Provide a fallback color if you want separators even with transparent themes.
    return
  end

  local sep = { fg = fg, bg = bg }
  local sep_sel = { fg = fg, bg = bg, underline = true }

  vim.api.nvim_set_hl(0, 'BufferLineSeparator', sep)
  vim.api.nvim_set_hl(0, 'BufferLineSeparatorVisible', sep)
  vim.api.nvim_set_hl(0, 'BufferLineSeparatorSelected', sep_sel)
  vim.api.nvim_set_hl(0, 'BufferLineTabSeparator', sep)
  vim.api.nvim_set_hl(0, 'BufferLineTabSeparatorSelected', sep_sel)
  vim.api.nvim_set_hl(0, 'BufferLineOffsetSeparator', sep)
end

set_bufferline_separator_variants()
vim.api.nvim_create_autocmd('ColorScheme', { callback = set_bufferline_separator_variants })

require('vim._core.ui2').enable()
-- vim: ts=2 sts=2 sw=2 et
