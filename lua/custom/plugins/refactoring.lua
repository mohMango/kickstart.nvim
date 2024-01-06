return {
  'ThePrimeagen/refactoring.nvim',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-treesitter/nvim-treesitter' },
  },
  config = function()
    require('refactoring').setup {}
    vim.keymap.set({ 'n', 'x' }, '<leader>rs', function()
      require('refactoring').select_refactor {}
    end, { desc = '[r]efactoring [s]election' })

    vim.keymap.set({ 'x', 'n' }, '<leader>rv', function()
      require('refactoring').debug.print_var {}
    end, { desc = '[r]efactoring print [v]ar' })

    vim.keymap.set('n', '<leader>rc', function()
      require('refactoring').debug.cleanup {}
    end, { desc = '[r]efactoring [c]leanup' })
  end,
}
