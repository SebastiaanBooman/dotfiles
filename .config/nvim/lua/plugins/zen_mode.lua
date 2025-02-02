return {
  'folke/zen-mode.nvim',
  opts = {
    plugins = {
      -- disable some global vim options (vim.o...)
      -- comment the lines to not apply the options
      options = {
        -- you may turn on/off statusline in zen mode by setting 'laststatus'
        -- statusline will be shown only if 'laststatus' == 3
        laststatus = 3, -- turn off the statusline in zen mode
      },
    },
    on_close = function()
      --NOTE: Workaround as zen-mode plugin has sanity check that calls "close" upon calling "open and "toggle"
      -- But Neovim should only close upon exiting the zen mode buffer, so we use the global variable "zen_mode"
      if vim.fn.exists 'g:zen_mode' == 0 or not vim.g.zen_mode then
        return
      end
      vim.g.zen_mode = false
      vim.cmd 'quit'
    end,
  },
}
