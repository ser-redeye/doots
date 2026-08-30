-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.mouse = "a" -- Enable mouse support (:help mouse)
vim.opt.termguicolors = true -- True color support

vim.opt.tabstop = 4 -- Tabs are 4 spaces
-- vim.opt.shiftwidth = 4          -- Indent width is 4 spaces (Handled by sleuth.vim plugin)
-- vim.opt.expandtab = true        -- Expand tab to spaces (Handled by sleuth.vim plugin)
vim.opt.autoindent = true -- Copy indent from current line when starting new one
vim.opt.smartindent = true -- Enable smart autoindenting (:help smartindent)
vim.opt.breakindent = true -- Wrapped line will continue to be visually indented

vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.number = true -- Show absolute current line number
vim.opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor

vim.opt.showmode = false -- Disable mode indicator, since status line exists
vim.opt.cursorline = true -- Show current line indicator

vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- When search pattern includes mixed case, follow case-sensitivity
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!

vim.opt.splitright = true -- Split vertical window to the right
vim.opt.splitbelow = true -- Split horizontal window to the bottom

vim.opt.updatetime = 250 -- Reduce updatetime for snappy responses (:help updatetime)
vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time to display which-key popup sooner

vim.opt.swapfile = false -- Disable creating swapfiles
vim.opt.undofile = true -- Enable saving undo history to file

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'` and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
