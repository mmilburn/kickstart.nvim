---@module 'lazy'
---@type LazySpec
return {
  'DrKJeff16/project.nvim',
  cmd = { -- Lazy-load by commands
    'Project',
    'ProjectAdd',
    'ProjectConfig',
    'ProjectDelete',
    'ProjectExportJSON',
    'ProjectImportJSON',
    'ProjectHealth',
    'ProjectHistory',
    'ProjectRecents',
    'ProjectRoot',
    'ProjectSession',
  },
  dependencies = { -- OPTIONAL
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  opts = {},
}
