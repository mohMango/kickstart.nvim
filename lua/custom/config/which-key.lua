return {
  mode = { 'n' },
  w = { ':w<CR>', 'Save current buffer' },
  W = { ':wa<CR>', 'Save all buffers' },
  q = { ':q<CR>', '[q]uit window' },
  Q = { ':q<CR>', '[Q]uit window' },
  e = { ':ExploreFind<CR>', 'File [e]xplorer' },
  E = { ':LexploreFind<CR>', 'Side File [E]xplorer' },
  b = {
    d = { ':bd<cr>', '[b]uffers [d]elete' },
    D = { ':bufdo bd<cr>', '[e] [b]uffers all [D]elete' },
  },
  u = { '<CMD>UndotreeToggle<CR><CMD>UndotreeFocus<CR>', '[u]ndo tree' },
}
