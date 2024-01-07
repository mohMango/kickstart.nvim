return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },

  config = function()
    require('nvim-treesitter.configs').setup {
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = {
        'c',
        'cpp',
        'go',
        'lua',
        'python',
        'rust',
        'tsx',
        'javascript',
        'typescript',
        'vimdoc',
        'vim',
        'html',
        'css',
        'json',
        'gomod',
        'gosum',
        'yaml',
        'markdown',
        'regex',
        'markdown_inline',
        'bash',
      },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      -- List of parsers to ignore installing (or "all")
      ignore_install = {},
      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = false,
      modules = {},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = false,
      },
      textobjects = {
        select = {
          enable = false,
          lookahead = false, -- Automatically jump forward to textobj, similar to targets.vim
        },
        move = {
          enable = false,
          set_jumps = true, -- whether to set jumps in the jumplist
        },
        swap = {
          enable = false,
        },
      },
    }
  end,
}
