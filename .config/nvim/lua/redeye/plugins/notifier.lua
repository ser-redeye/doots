-- [nvim-notify](https://github.com/rcarriga/nvim-notify)
--
-- A fancy notification manager for neovim
--
-- Shortcuts Available:
-- <leader>un - Dismiss all notifications visible on the screen
-- <leader>us - Show all notifications using Telescope
--
-- NOTE:
-- Test a notification with the following format
-- require("notify")("My super important message")

return {
  'rcarriga/nvim-notify',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  keys = {
    {
      '<leader>un',
      function()
        require('notify').dismiss { silent = true, pending = true }
      end,
      desc = 'Dismiss All Notifications',
    },
    {
      '<leader>us',
      '<cmd>Telescope notify<CR>',
      desc = 'Show All Notifications',
    },
  },
  opts = {
    render = 'compact',
    stages = 'fade_in_slide_out',
    timeout = 5000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,
  },
  init = function()
    vim.notify = require 'notify'
  end,
}
