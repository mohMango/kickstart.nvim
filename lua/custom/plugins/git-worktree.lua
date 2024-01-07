return {
  'ThePrimeagen/git-worktree.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function()
    local telescope = require 'telescope'
    pcall(telescope.load_extension 'git_worktree')

    vim.keymap.set('n', '<leader>gws', function()
      telescope.extensions.git_worktree.git_worktrees()
    end, { desc = '[g]it [w]orktree[s]' })
    vim.keymap.set('n', '<leader>gwc', function()
      telescope.extensions.git_worktree.create_git_worktree()
    end, { desc = '[g]it [w]orktree [c]reate' })
  end,
}
