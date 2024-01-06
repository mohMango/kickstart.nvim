return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    {
      'williamboman/mason.nvim',
      event = 'VeryLazy',
      config = true,
      opts = {
        ui = {
          border = 'rounded',
        },
      },
    },
    'williamboman/mason-lspconfig.nvim',
    {
      'j-hui/fidget.nvim',
      opts = {
        notification = {
          window = {
            relative = 'editor', -- where to anchor, either "win" or "editor"
            winblend = 0, -- &winblend for the window
            zindex = nil, -- the zindex value for the window
            border = '', -- style of border for the fidget window
          },
        },
      },
    },
    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      lazy = true,
      opts = {},
      dependencies = {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',

        -- Snippets
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
      },
    },
    {
      'ray-x/lsp_signature.nvim',
      event = 'VeryLazy',
      opts = {},
      --[[ config = function(_, opts)
        require('lsp_signature').setup(opts)
      end, ]]
    },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
  },
  config = function()
    require('lspconfig.ui.windows').default_options.border = 'rounded'

    -- Setup neovim lua configuration
    require('neodev').setup()

    require('mason-lspconfig').setup {
      handlers = {
        require('lsp-zero').default_setup,
      },
    }

    require 'custom.config.lsp.lsp-zero'
    require 'custom.config.lsp.templ'
  end,
}
