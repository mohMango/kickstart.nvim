local lspconfig = require 'lspconfig'
-- additional filetypes
vim.filetype.add {
  extension = {
    templ = 'templ',
  },
}
lspconfig.tailwindcss.setup {
  filetypes = {
    'templ',
    'html',
    -- include any other filetypes where you need tailwindcs
  },
  init_options = {
    userLanguages = {
      templ = 'html',
    },
  },
}

lspconfig.htmx.setup {
  filetypes = {
    'templ',
  },
  init_options = {
    userLanguages = {
      templ = 'html',
    },
  },
}
