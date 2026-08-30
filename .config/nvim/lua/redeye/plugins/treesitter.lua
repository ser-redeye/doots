-- Treesitter environment and plugins for Neovim

return {

  -- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/tree/main)
  --
  -- A configuration and abstraction layer for Neovim's Treesitter.
  -- Enables built-in tree-sitter features.
  --
  -- TODO: Checkout [Treesitter + textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    opts = {
      indent = { enable = true },
      highlight = { enable = true },
      fold = { enable = true },
    },
    config = function(_, opts)
      local TS = require 'nvim-treesitter'
      local ensure_installed = {
        'bash',
        'c',
        'cpp',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
        'regex',
        'printf',
      }

      local pre_installed = require('nvim-treesitter.config').get_installed()
      local to_install = vim
        .iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(pre_installed, parser)
        end)
        :totable()
      require('nvim-treesitter').install(to_install)

      vim.api.nvim_create_autocmd('FileType', {
        desc = 'User: enable treesitter highlighting',
        callback = function(ctx)
          local hasStarted

          -- highlights
          if vim.tbl_get(opts, 'highlight', 'enable') ~= false then
            -- errors for filetypes with no parser
            hasStarted = pcall(vim.treesitter.start)
          end

          -- indent
          local noIndent = {}
          if vim.tbl_get(opts, 'indent', 'enable') ~= false and hasStarted and not vim.list_contains(noIndent, ctx.match) then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end

          -- fold
          -- TODO: Currently have never used folds in neovimn.
          -- Experiment with folding and understand it better
          if vim.tbl_get(opts, 'fold', 'enable') ~= false and hasStarted then
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            -- default foldlevel was 0, so, automatically all folds are
            -- closed I want manual control over my folding.
            vim.wo.foldlevel = 99
          end
        end,
      })
    end,
  },

  -- [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)
  --
  -- Provides a context window for the current buffer.
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = { enable = true, max_lines = 3 },
  },

  -- [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)
  --
  -- auto close and auto rename html tag
  {
    'windwp/nvim-ts-autotag',
  },
}
