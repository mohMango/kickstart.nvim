--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, understand
  what your configuration is doing, and modify it to suit your needs.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/


  And then you can explore or search through `:help lua-guide`
  - https://neovim.io/doc/user/lua-guide.html


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
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

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      {
        'williamboman/mason.nvim',
        config = true,
        opts = {
          ui = {
            border = 'rounded',
          },
        },
      },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        opts = {
          window = {
            relative = 'win', -- where to anchor, either "win" or "editor"
            blend = 0, -- &winblend for the window
            zindex = nil, -- the zindex value for the window
            border = 'none', -- style of border for the fidget window
          },
        },
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
    config = function()
      require('lspconfig.ui.windows').default_options.border = 'rounded'
    end,
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
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
  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      window = {
        border = 'rounded', -- none, single, double, shadow
      },
    },
  },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame = true,
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })
        vim.keymap.set('n', '<leader>gr', require('gitsigns').reset_hunk, { buffer = bufnr, desc = 'Reset git hunk' })
        vim.keymap.set('n', '<leader>gb', require('gitsigns').blame_line, { buffer = bufnr, desc = 'Blame line' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },

  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_foreground = 'material'
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_disable_italic_comment = 0
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_transparent_background = 0
      vim.g.gruvbox_material_ui_contrast = 'high'
      vim.g.gruvbox_material_diagnostic_line_highlight = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
      -- vim.cmd.colorscheme 'gruvbox-material'
    end,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'macchiato', -- latte, frappe, macchiato, mocha
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        custom_highlights = function(colors)
          return {
            netrwTreeBar = { fg = colors.surface0 },
          }
        end,
      }
      -- setup must be called before loading
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'catppuccin',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = 'ibl',
    opts = {
      indent = {
        char = '┊',
      },
      scope = { enabled = false },
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {},
    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end,
  },
  { 'mbbill/undotree' },
  {
    'windwp/nvim-autopairs',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  { 'Ciel-MC/rust-tools.nvim' },
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local conform = require 'conform'
      conform.setup {
        formatters_by_ft = {
          javascript = { { 'prettierd', 'prettier' } },
          typescript = { { 'prettierd', 'prettier' } },
          javascriptreact = { { 'prettierd', 'prettier' } },
          typescriptreact = { { 'prettierd', 'prettier' } },
          svelte = { { 'prettierd', 'prettier' } },
          css = { { 'prettierd', 'prettier' } },
          html = { { 'prettierd', 'prettier' } },
          json = { { 'prettierd', 'prettier' } },
          lua = { 'stylua' },
          cpp = { 'clang_format' },
        },
      }

      vim.keymap.set({ 'n', 'x' }, '<leader>lf', function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        }
      end, { desc = '[l]sp [f]ormat Buffer' })
    end,
  },
  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {
  ui = {
    border = 'rounded',
  },
})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

local options = {
  breakindent = true, -- Enable break indent
  completeopt = 'menuone,noselect', -- Set completeopt to have a better completion experience
  hlsearch = false, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  termguicolors = true, -- set term gui colors (most terminals support this)
  undofile = true, -- enable persistent undo
  expandtab = true, -- convert tabs to spaces
  cursorline = false, -- highlight the current line
  number = true, -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor.
  sidescrolloff = 8, -- minimal number of screen lines to keep left and right of the cursor.
  guicursor = 'a:blinkon1',
  foldmethod = 'indent',
  foldenable = false,
  foldlevel = 99,

  backup = false, -- creates a backup file
  clipboard = 'unnamedplus', -- allows neovim to access the system clipboard
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = 'utf-8', -- the encoding written to a file
  foldexpr = '', -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
  guifont = 'monospace:h17', -- the font used in graphical neovim applications
  hidden = true, -- required to keep multiple buffers and open multiple buffers
  mouse = 'a', -- allow the mouse to be used in neovim
  pumheight = 10, -- pop up menu height
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  smartcase = true, -- smart case
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
  title = true, -- set the title of window to the value of the titlestring
  updatetime = 250, -- faster completion
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = 'yes', -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  showcmd = false,
  ruler = false,
  laststatus = 3,
}
for key, value in pairs(options) do
  if vim.bo.filetype ~= 'lazy' then
    vim.opt[key] = value
  end
end

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('v', 'p', '"_dP', { desc = '' })

vim.keymap.set('n', '<leader>w', ':w<cr>', { desc = 'Save current buffer' })
vim.keymap.set('n', '<leader>W', ':wa<cr>', { desc = 'Save all buffers' })
vim.keymap.set('n', '<leader>q', ':q<cr>', { desc = '[q]uit window' })
vim.keymap.set('n', '<leader>Q', ':qa<cr>', { desc = '[Q]uit Neovim' })
vim.keymap.set('n', '<leader>e', ':ExploreFind<cr>', { desc = 'File [e]xplorer' })
vim.keymap.set('n', '<leader>E', ':VexploreFind<cr>', { desc = 'Side File [E]xplorer' })
vim.keymap.set('n', '<leader>bd', ':bd<cr>', { desc = '[b]uffers [d]elete' })
vim.keymap.set('n', '<leader>bD', ':bufdo bd<cr>', { desc = '[e] [b]uffers all [D]elete' })

-- Better window navigation
-- vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = '' })
-- vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = '' })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = '' })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = '' })

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', { desc = '' })
vim.keymap.set('v', '>', '>gv', { desc = '' })

-- Move text up and down
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = '' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = '' })

vim.keymap.set('n', '<leader>u', '<CMD>UndotreeToggle<CR><CMD>UndotreeFocus<CR>', { desc = '[u]ndo tree' })

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', function()
  require('telescope.builtin').git_files(require('telescope.themes').get_dropdown {
    previewer = false,
  })
end, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', function()
  require('telescope.builtin').find_files(require('telescope.themes').get_dropdown {
    previewer = false,
  })
end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim' },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (or "all")
  ignore_install = {},

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  modules = {},

  highlight = { enable = true },
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

-- Setup neovim lua configuration
require('neodev').setup()

-- [[ LSP ]]
-- Ensure the servers above are installed
local lsp_zero = require 'lsp-zero'

lsp_zero.extend_lspconfig()
lsp_zero.on_attach(function(_, _)
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = '[l]sp code [a]ction' })
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = '[l]sp [r]enames' })
  -- vim.keymap.set({ 'n', 'x' }, '<leader>lf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
  --   { desc = '[l]sp [f]ormat Buffer' })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[g]o [d]efinition' })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[g]o [D]eclaration' })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = '[g]o [i]mplementation' })
  vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, { desc = 'Type Definition' })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = '[g]o [r]eferences' })
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = '[g]o [s]ignature' })
  -- Diagnostic keymaps
  vim.keymap.set('n', '<leader>lk', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
  vim.keymap.set('n', '<leader>lj', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
  vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
  vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

  -- if vim.lsp.buf.range_code_action then
  --   vim.keymap.set('x', '<leader>la', vim.lsp.buf.range_code_action, { desc = '[l]sp code [a]ction' })
  -- else
  --   vim.keymap.set('x', '<leader>la', vim.lsp.buf.code_action, { desc = '[l]sp code [a]ction' })
  -- end
end)

require('mason-lspconfig').setup {
  handlers = {
    lsp_zero.default_setup,
  },
}

local cmp_action = require('lsp-zero').cmp_action()
local cmp = require 'cmp'
cmp.setup {
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      select = true,
    },
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  },
  formatting = {
    -- changing the order of fields so the icon is the first
    fields = { 'menu', 'abbr', 'kind' },

    -- here is where the change happens
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
        nvim_lua = 'Π',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
}

local rust_tools = require 'rust-tools'
rust_tools.setup {
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set('n', '<Leader>rr', rust_tools.runnables.runnables, { buffer = bufnr, desc = '[r]ust [r]un' })
      rust_tools.inlay_hints.enable()
    end,
  },
}

-- [[ NETRW ]]
vim.g.netrw_liststyle = 4
vim.g.netrw_browse_split = 0
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25
vim.g.netrw_list_hide = vim.fn['netrw_gitignore#Hide']()

-- [[ autocommands ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'qf', 'help', 'man', 'lspinfo', 'spectre_panel', 'lir' },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.cmd [[
      setlocal wrap
      setlocal spell
    ]]
  end,
})

vim.api.nvim_create_autocmd({ 'VimResized' }, {
  callback = function()
    vim.cmd 'tabdo wincmd ='
  end,
})

vim.api.nvim_create_autocmd({ 'FocusGained' }, {
  pattern = { '*' },
  callback = function()
    vim.cmd [[
      :checktime
    ]]
  end,
})

vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  pattern = { '*' },
  callback = function()
    vim.cmd [[
      if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
    ]]
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'netrw' },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> <leader>q :bd<CR>
      set nobuflisted
    ]]
  end,
})

-- show file in netrw
-- more info: https://superuser.com/questions/1531456/how-to-reveal-a-file-in-vim-netrw-treeview
vim.api.nvim_create_user_command('ExploreFind', function()
  vim.cmd [[:let netrw_browse_split = 0]]
  local relative_path = vim.fn.expand '%:h'
  vim.cmd.let '@/=expand("%:t")'
  if string.len(relative_path) == 0 then
    vim.cmd.let "@/='./'"
  end
  vim.cmd('Explore ' .. relative_path)
  vim.cmd.normal 'n'
  vim.cmd.normal 'zz'
end, {})

Netrw_buffer = -1
vim.api.nvim_create_user_command('VexploreFind', function()
  if Netrw_buffer == -1 then
    vim.cmd [[:let netrw_browse_split = 4]]
    local relative_path = vim.fn.expand '%:h'
    vim.cmd.let '@/=expand("%:t")'
    if string.len(relative_path) == 0 then
      vim.cmd.let "@/='./'"
    end
    vim.cmd('Vexplore ' .. relative_path)
    vim.cmd.normal 'n'
    vim.cmd.normal 'zz'
    local buf = vim.api.nvim_get_current_buf()
    Netrw_buffer = vim.fn.bufnr(buf)
  else
    vim.api.nvim_buf_delete(Netrw_buffer, {})
    Netrw_buffer = -1
  end
end, {})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
