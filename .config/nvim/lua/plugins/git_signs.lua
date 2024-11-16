-- Adds git related signs to the gutter, as well as utilities for managing changes
-- See `:help gitsigns` to understand what the configuration keys do
return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      jhange = { text = '~' },
      delete = { text = '-' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
}
