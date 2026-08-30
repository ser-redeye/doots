-- [[ Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set leader key as <SPACE>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable arrow keys in normal mode (Don't be a noob and comment this)
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Copy to system clipboard
vim.keymap.set('v', '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Yank → Clipboard' })
vim.keymap.set('n', '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Yank → Clipboard' })

-- Paste from system clipboard
-- vim.keymap.set('n', '<leader>p', '"+p', { noremap = true, silent = true, desc = 'Put → Clipboard' })
-- vim.keymap.set('n', '<leader>P', '"+P', { noremap = true, silent = true, desc = 'Put → Clipboard' })
-- vim.keymap.set('v', '<leader>p', '"+p', { noremap = true, silent = true, desc = 'Put → Clipboard' })
-- vim.keymap.set('v', '<leader>P', '"+P', { noremap = true, silent = true, desc = 'Put → Clipboard' })

-- Clear highlighting for pattern search on <Esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
