-- [Harpoon](https://github.com/ThePrimeagen/harpoon/tree/harpoon2)
--
-- Getting you where you want with the fewest keystrokes.
-- Move like Coconut oil accross files.

-- Usefull Shortcuts available:
-- <leader>aa - Add current file to harpoon list
-- <leader>i  - harpoon to ith file in the list (1 < i < 5)
-- <leader>at - Open harpoon list in a telescope picker
-- <leader>ae - Open harpoon list in native menu (i use it for editing my list)
-- <leader>al - Show debugging logs for harpoon
-- <C-M-p>    - harpoon to previous file
-- <C-M-n>    - harpoon to next file
--
-- While in the harpoon telescope picker, entries can be removed by <Ctrl+d>

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  opts = {
    -- save_on_toggle saves the list to memory (Not Filesystem) on menu toggle
    settings = { save_on_toggle = true },
  },
  config = function()
    local harpoon = require 'harpoon'

    local function toggle_telescope_with_harpoon(harpoon_files)
      local finder = function()
        local paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(paths, item.value)
        end

        return require('telescope.finders').new_table {
          results = paths,
        }
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = finder(),
          previewer = require('telescope.config').values.file_previewer {},
          sorter = require('telescope.config').values.generic_sorter {},
          attach_mappings = function(prompt_buffer_number, map)
            map('i', '<C-d>', function()
              local state = require 'telescope.actions.state'
              local selected_entry = state.get_selected_entry()
              local current_picker = state.get_current_picker(prompt_buffer_number)

              table.remove(harpoon_files.items, selected_entry.index)
              current_picker:refresh(finder())
            end)

            return true
          end,
        })
        :find()
    end

    vim.keymap.set('n', '<leader>aa', function()
      harpoon:list():add()
    end, { desc = 'Add harpoon file' })
    vim.keymap.set('n', '<leader>ae', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon quick menu' })
    vim.keymap.set('n', '<leader>at', function()
      toggle_telescope_with_harpoon(harpoon:list())
    end, { desc = 'Open harpoon window' })
    vim.keymap.set('n', '<leader>al', function()
      harpoon.logger:show()
    end, { desc = 'Show Harpoon Logs' })
    vim.keymap.set('n', '<C-M-p>', function()
      harpoon:list():prev()
    end, { desc = 'Go to previous harpoon mark' })
    vim.keymap.set('n', '<C-M-n>', function()
      harpoon:list():next()
    end, { desc = 'Go to next harpoon mark' })
    for i = 1, 5 do
      vim.keymap.set('n', '<leader>' .. i, function()
        harpoon:list():select(i)
      end, { desc = 'Harpoon to file ' .. i })
    end
  end,
}
