-- Miscelanious Plugins for Neovim

return {
  -- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
  --
  -- Neovim-tmux integrated pane navigation utility. Allows you to navigate
  -- seamlessly between vim and tmux splits using a consistent set of hotkeys.
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- [zen-mode](https://github.com/folke/zen-mode.nvim)
  --
  -- Enable a distraction free coding enviromnent.
  -- Usefull Shortcuts available:
  -- <leader>zz - Enter Zen Mode
  {
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    keys = { { "<leader>zz", "<cmd>ZenMode<CR>", desc = "[Z]en Mode" } },
    opts = {
      window = {
        -- Shade the backdrop of the Zen window. Set to 1
        -- to keep the same as Normal
        backdrop = 0.95,
      },
      plugins = {
        options = {
          enabled = true,
          -- you may turn on/off statusline in zen mode by setting 'laststatus'
          -- statusline will be shown only if 'laststatus' == 3
          -- if `laststatus` == 0, turn off the statusline
          laststatus = 0,
        },
        twilight = { enabled = true },
        tmux = { enabled = true },
      },
    },
  },

  -- [which-key](https://github.com/folke/which-key.nvim)
  --
  -- TODO: Need to port all the keys, verify at the end.
  --
  -- Helps you remember your Neovim keymaps, by showing available keybindings
  -- in a popup as you type.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    init = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
        { "<leader>a", group = "Harpoon" },
        { "<leader>m", group = "[M]axLinear" },
      })
    end,
  },

  -- [todo-comments](https://github.com/folke/todo-comments.nvim)
  --
  -- Highlight todo, notes, etc in comments
  -- There are 6 usable highlights - TODO, HACK, WARN, PERF, NOTE, TEST

  -- Commands & Shortcuts available:
  -- [t             - Previous [T]odo-Comment
  -- ]t             - Next [T]odo-Comment
  -- :TodoTrouble   - List all project todos using trouble.
  -- :TodoTelescope - List all project todos using telescope
  --
  -- Options available with the commands:
  -- cwd      - Specify the directory to search for comments
  -- keywords - Comma separated list of keywords to filter results by.
  --            Keywords are case-sensitive.
  -- E.G.; :TodoTelescope cwd=~/projects/foobar keywords=TODO,FIX
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = false,
    },
    keys = {
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous [T]odo-Comment",
      },
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next [T]odo-Comment",
      },
    },
  },

  -- [Yanky](https://github.com/gbprod/yanky.nvim)
  --
  -- Power-up Neovim's Yank and Put functionality
  {
    "gbprod/yanky.nvim",
    opts = {},
    keys = {
      {
        "y",
        "<Plug>(YankyYank)",
        mode = { "n", "x" },
        desc = "Yank text",
      },
      {
        "p",
        "<Plug>(YankyPutAfter)",
        mode = { "n", "x" },
        desc = "Put yanked text after cursor",
      },
      {
        "P",
        "<Plug>(YankyPutBefore)",
        mode = { "n", "x" },
        desc = "Put yanked text before cursor",
      },
      {
        "gp",
        "<Plug>(YankyGPutAfter)",
        mode = { "n", "x" },
        desc = "Put yanked text after selection",
      },
      {
        "gP",
        "<Plug>(YankyGPutBefore)",
        mode = { "n", "x" },
        desc = "Put yanked text before selection",
      },
      {
        "<leader>p",
        function()
          require("telescope").extensions.yank_history.yank_history({})
        end,
        desc = "Open Yank History",
      },
      { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
      { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
      { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
      { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
      { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
      { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
      { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
      { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
    },
  },

  -- [Trouble](https://github.com/folke/trouble.nvim)
  --
  -- A pretty diagnostics, references, telescope results, quickfix
  -- and location list to help solve all the trouble with the code.
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- [Comment](https://github.com/numToStr/Comment.nvim)
  --
  -- Smart and Powerful commenting plugin for neovim
  {
    "numToStr/Comment.nvim",
    opts = {
      ignore = "^$", -- Ignore empty lines
      pre_hook = function()
        return vim.bo.commentstring
      end,
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        opts = { enable_autocmd = false },
      },
    },
  },

  -- [cscope_maps](https://github.com/dhananjaylatkar/cscope_maps.nvim)
  --
  -- Faster & powerful cscope
  {
    "dhananjaylatkar/cscope_maps.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      prefix = "<leader>q", -- prefix to trigger maps
      cscope = { picker = "telescope" },
    },
  },
}
