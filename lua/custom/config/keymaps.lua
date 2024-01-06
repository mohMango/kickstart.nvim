local opts = { noremap = true, silent = true }

-- Keep cursor centered when scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', opts)

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('v', 'p', '"_dP', { desc = '' })

-- Better window navigation
-- vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = '' })
-- vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = '' })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = '' })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = '' })

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Move text up and down
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)
