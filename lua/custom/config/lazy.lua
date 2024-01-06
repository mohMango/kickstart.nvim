local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('custom.plugins', {
  install = {
    missing = true,
    colorscheme = { 'gruvbox-material', 'habamax' },
  },
  ui = {
    border = 'rounded',
  },
  checker = {
    enabled = true,
    notify = true,
  },
  change_detection = {
    enabled = true,
    notify = true,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
