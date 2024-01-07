vim.g.netrw_liststyle = 1
vim.g.netrw_browse_split = 0
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25
vim.g.netrw_list_hide = vim.fn['netrw_gitignore#Hide']()
vim.g.netrw_banner = 1
vim.g.netrw_clipboard = 0
vim.g.netrw_sizestyle = 'H'
vim.g.netrw_sort_by = 'exten'

-- show file in netrw
-- more info: https://superuser.com/questions/1531456/how-to-reveal-a-file-in-vim-netrw-treeview
vim.api.nvim_create_user_command('ExploreFind', function()
  local relative_path = vim.fn.expand '%:h'
  vim.cmd.let '@/=expand("%:t")'
  if string.len(relative_path) == 0 then
    vim.cmd.let "@/='./'"
  end
  vim.cmd('Explore ' .. relative_path)
  vim.cmd.normal 'n'
  vim.cmd.normal 'zz'
end, {})

vim.api.nvim_create_user_command('LexploreFind', function()
  local relative_path = vim.fn.expand '%:h'
  vim.cmd.let '@/=expand("%:t")'
  if string.len(relative_path) == 0 then
    vim.cmd.let "@/='./'"
  end
  vim.cmd('Lexplore ' .. relative_path)
  vim.cmd.normal 'n'
  vim.cmd.normal 'zz'
end, {})
