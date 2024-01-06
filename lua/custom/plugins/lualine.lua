return {
  'nvim-lualine/lualine.nvim',
  event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
  opts = {
    options = {
      icons_enabled = false,
      theme = 'auto',
      component_separators = '|',
      section_separators = '',
      globalstatus = true,
    },
  },
}
