-- File System plugins for Neovim

return {

  -- [oil](https://github.com/stevearc/oil.nvim)
  --
  -- File explorer to edit fs like a normal Neovim buffer.
  -- Coconut oil like file system interaction.
  --
  -- Usefull Shortcuts available:
  --
  -- Available anywhere:
  --   <leader>o - Toggle Oil buffer
  --
  -- Only inside the Oil buffer;
  --   g?    - Opens keymap's window
  --   `     - CD to current oil directory
  --   -     - Navigate to Parent directory
  --   <CR>  - Open entry under curset (current window)
  --   <C-p> - Toggle Preview screen (Opens for current entry)
  --   <C-c> - Close oil and restore original buffer
  --   g.    - Toggle hidden files/dirs
  --   gs    - Change sort order
  --   gd    - Toggle detailed view
  {
    'stevearc/oil.nvim',
    -- Lazy loading is not recommended because it is very tricky to make it
    -- work correctly in all situations.
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      -- Id is automatically added at the beginning, and name at the end
      -- See :help oil-columns
      columns = {
        'icon',
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      -- Window-local options to use for oil buffers
      win_options = {
        signcolumn = 'yes:2',
      },
      -- Skip the confirmation popup for simple operations
      -- (:help oil.skip_confirm_for_simple_edits)
      skip_confirm_for_simple_edits = true,
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 5,
      },
      -- Keymaps in oil buffer. Can be any value that `vim.keymap.set`
      -- accepts OR a table of keymap options with a `callback`
      -- (e.g. { callback = function() ... end, desc = "", mode = "n" })
      -- Additionally, if it is a string that matches "actions.<name>",
      -- it will use the mapping at require("oil.actions").<name>
      -- Set to `false` to remove a keymap
      -- See :help oil-actions for a list of all available actions
      keymaps = {
        ['g?'] = { 'actions.show_help', mode = 'n', desc = 'Show Oil keymaps' },
        ['<CR>'] = 'actions.select',
        -- TODO: Need to find a better way to do this so i can use the
        -- same shortcut accross all plugins for opening entries in a
        -- Vertical pane/Horizontal pane/new Tab.
        ['<C-s>'] = false,
        ['<C-t>'] = false,
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['<C-p>'] = 'actions.preview',
        ['<C-c>'] = { 'actions.close', mode = 'n' },
        ['-'] = { 'actions.parent', mode = 'n' },
        ['_'] = { 'actions.open_cwd', mode = 'n' },
        ['`'] = { 'actions.cd', mode = 'n' },
        ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
        ['gs'] = { 'actions.change_sort', mode = 'n' },
        ['gx'] = false, -- dont need it.
        ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
        ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
        -- Custom
        ['gd'] = {
          desc = 'Toggle file detail view',
          callback = function()
            local detail = vim.b.oil_detail_view or false
            detail = not detail
            vim.b.oil_detail_view = detail
            if detail then
              require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
            else
              require('oil').set_columns { 'icon' }
            end
          end,
        },
      },
    },
    init = function()
      -- Key mappings for oil
      vim.keymap.set('n', '<leader>o', require('oil').toggle_float, { desc = 'Toggle [O]il Buffer' })
    end,
  },

  -- [oil-git-status](https://github.com/refractalize/oil-git-status.nvim)
  --
  -- Add Git Status to oil.nvim directory listings. The plugin puts the status
  -- in two new sign columns, the left being the status of the index, the right
  -- being the status of the working directory, just as you'd get if you ran:
  -- `git status --short.`
  {
    'refractalize/oil-git-status.nvim',
    dependencies = { 'stevearc/oil.nvim' },
    opts = {},
  },
}
