return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  lazy = true,
  opts = {
    window = {
      border = 'rounded', -- none, single, double, shadow
    },
  },
  config = function(_, opts)
    local which_key = require 'which-key'
    which_key.setup(opts)
    which_key.register(require 'custom.config.which-key', {
      mode = 'n',
      prefix = '<leader>',
    })
  end,
}
