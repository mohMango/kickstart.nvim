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

require('luasnip.loaders.from_vscode').lazy_load()

local cmp_action = lsp_zero.cmp_action()
local cmp = require 'cmp'
cmp.setup {
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'nvim_lua' },
  },
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
      return item
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
}
