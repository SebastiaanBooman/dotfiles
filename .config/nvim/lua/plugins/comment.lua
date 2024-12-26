return {
  'numToStr/Comment.nvim',
  opts = {},
  config = function()
    vim.keymap.set('v', '<C-_>', function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'v', false)
      vim.defer_fn(function() -- need to defer the comment function because else it executes too fast?
        require('Comment.api').toggle.linewise(vim.fn.visualmode())
      end, 0)
    end)
  end,
  mappings = {
    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
    basic = false,
    ---Extra mapping; `gco`, `gcO`, `gcA`
    extra = false,
  },
}
