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

-- wrap words "softly" (no carriage return)
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt.textwidth = 0
    vim.opt.wrapmargin = 0
    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.opt.spell = true
  end,
})

-- resize neovim split when terminal is resized
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

-- go to last loc when opening a buffer
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
      nnoremap <silent> <buffer> <leader>e :bd<CR>
      set nobuflisted
    ]]
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'Normal' })
    vim.api.nvim_set_hl(0, 'LspInfoBorder', { link = 'Normal' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Normal' })
  end,
})
