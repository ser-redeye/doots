return {

  -- Greeter
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local dashboard = require("alpha.themes.dashboard")

      -- dashboard.section.header.val = {
      --   "⣿⣿⣿⣿⡿⠛⠛⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠛⠛⢿⣿⣿⣿⣿",
      --   "⣿⣿⣿⣿⠁⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠛⠛⠛⠛⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀⠀⠀⠈⣿⣿⣿⣿",
      --   "⣿⠋⠉⠁⠀⠀⠀⠀⢴⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠈⠉⠻⣿",
      --   "⣿⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⠟⠁⣰⡆⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣄⡈⠻⣿⣿⣿⣿⡿⠏⠀⠀⠀⠀⠀⠀⠀⠀⣿",
      --   "⣿⣦⣄⣀⣤⣶⣄⠀⠀⠀⠀⠙⢿⡿⠃⠀⡾⠃⣰⠟⢠⡟⠀⠀⠀⠀⠀⠀⠀⠀⢿⡄⠈⢿⡀⠈⢿⡿⠋⠀⠀⠀⠀⣠⣶⣄⣀⣀⣴⣿",
      --   "⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⢀⣿⣷⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣾⣷⣶⣾⣿⡄⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿",
      --   "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      --   "⣿⣿⣿⣿⣿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⣿⣿⣿⣿⣿",
      --   "⣿⣿⣿⣿⣿⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣼⣿⣿⣿⣿",
      --   "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⣀⣴⣶⣶⣄⠀⠀⠀⠀⠀⠀⣠⣴⣶⣦⣄⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      --   "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⢰⣿⣿⣿⣿⣿⣷⡄⠀⠀⢀⣾⣿⣿⣿⣿⣿⣇⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      --   "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⢸⣿⣿⣿⣿⣿⣿⠇⠀⠀⠘⣿⣿⣿⣿⣿⣿⡿⠀⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      --   "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣀⠀⠻⠿⣿⣿⠿⠋⠀⠀⠀⠀⠘⠿⢿⣿⡿⠿⠃⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      --   "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣀⠀⠀⠀⠀⠀⠐⢿⣿⠇⠀⠀⠀⠀⠀⣀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      --   "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⡿⠛⠲⠦⣤⣤⣤⣀⣀⣤⣤⣤⠴⠖⠛⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      --   "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⢸⢧⣀⠀⢰⡇⠀⠈⠉⡏⠉⠀⢸⠀⠀⢀⣼⡇⠙⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      --   "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⣟⠀⠈⠉⣾⠳⠶⠤⣤⣧⠤⠴⢾⡗⠉⠉⠀⢇⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      --   "⣿⣿⣿⣿⣿⡿⠋⠉⠙⠻⠛⠁⠀⠀⠀⢀⡏⠑⢶⣤⡟⠀⠀⠀⠀⡇⠀⠀⠀⣷⣠⡴⠖⢻⠀⠀⠀⠀⠈⠻⠟⠋⠉⠙⢿⣿⣿⣿⣿⣿",
      --   "⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣷⠀⠀⠀⠈⠉⠛⠛⠛⠛⠛⠛⠋⠉⠀⠀⠀⣾⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿",
      --   "⣿⣿⣿⣿⣿⣧⣀⣀⠀⠀⠀⠀⠐⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⠀⠀⠀⠀⢀⣀⣠⣾⣿⣿⣿⣿⣿",
      --   "⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣼⣿⣿⣿⣿⣇⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿",
      --   "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣤⣤⣴⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣤⣤⣤⣤⣴⣶⣿⣿⣿⣿⣿⣿⣿⣿⣦⣤⣤⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      -- }
      -- Set header
      dashboard.section.header.val = {
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣶⣾⡛⠛⠉⠙⠛⠳⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⢀⣴⠾⣶⡄⠀⡀⠀⠉⠛⢷⣆⠀⠀⠀⠈⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣀⠀⠀⠀",
        "⠀⠀⠀⣠⣾⡇⠀⢸⣇⣾⡇⠀⠀⠀⠀⣹⠇⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠏⠉⠙⣧⡀⠀",
        "⢠⣶⠟⠋⠉⠁⠀⢸⡿⠉⣷⣀⠀⢀⣴⠟⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣻⡆⠀⠀⠉⠛⣷",
        "⠸⣷⣄⣀⣠⣤⣠⡿⠀⠀⠈⠛⠛⠛⠁⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡾⠋⠀⣠⣄⣀⣠⡿",
        "⠀⠈⠻⣟⠛⠉⣿⠁⠀⣠⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⡿⠛⠻⠷⣦⣤⡀⠀⣠⡾⠋⠀⣠⣾⠟⠉⠉⠉⠀",
        "⠀⠀⠀⢻⣦⣸⣏⠀⢸⣏⠙⡇⠀⢀⣴⠞⠛⠀⣠⣄⣧⠀⠀⠀⣠⣭⡛⢿⣏⠀⢠⣾⠋⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⣿⠙⢻⣄⠀⠉⣸⠇⢀⣿⠁⠀⠀⣾⠉⠈⣟⠀⠀⠀⠉⢻⣿⣆⠙⣿⣟⠁⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⣿⠀⢀⣙⡛⠛⠉⠀⠘⣷⠀⠀⠀⠘⠛⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⣿⢠⣿⣏⢻⡆⠀⠀⠀⣹⣷⣄⡀⠀⠀⣠⣯⣉⣉⣉⣉⣉⣉⣉⣛⡛⠛⠿⠷⢤⣤⣀⡀⠀⠀",
        "⠀⠀⠀⢸⣿⠈⠻⠿⢸⣿⢠⡟⠻⠿⢀⣈⡙⠛⠛⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠛⠛⢿⡆⠀⣀⣉⣛⣷⣦",
        "⠀⠀⠀⠀⣿⡀⠀⠀⢻⣿⣌⣧⣴⣾⣿⣿⣿⣷⣄⠀⠀⠀⣠⣾⣿⣿⣿⣶⡄⠀⠀⣼⡟⠛⠉⠉⠉⠀⠀",
        "⠀⠀⠀⠀⠹⣧⡀⠀⠸⣯⠙⢻⣿⣿⣿⣿⣿⣿⣿⡆⠀⢸⣿⣿⣿⣿⣿⣿⣿⡀⢀⣿⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠈⠛⠷⠾⢿⣆⠸⣿⣿⣿⣿⣿⣿⣿⠃⠀⠸⣿⣿⣿⣿⣿⣿⡿⢁⣼⠇⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⠿⣧⡙⠿⢿⣿⡿⠟⠃⣤⣤⣄⠙⠻⠿⠿⠿⠛⣡⣾⣿⣄⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⢀⣴⠟⠁⠀⣨⡿⣶⣄⡀⠀⠀⠀⠿⣿⠟⠀⠀⠀⢀⣠⣾⣿⡁⠈⠻⣦⡀⠀⠀⠀⠀⠀",
        "⠀⣀⣴⠶⢦⣴⠟⠁⠀⣠⡾⠋⠀⠀⠙⣿⡶⣦⣤⣤⣤⣤⣤⣴⢾⣟⠉⠀⠘⢿⣦⡀⠈⠻⣦⣤⣤⣤⡀",
        "⠈⣿⠁⠀⠀⠀⠀⣠⡾⠋⠀⠀⠀⠀⢸⡟⢻⠷⠶⣿⠤⢿⡶⢿⡛⣿⡄⠀⠀⠀⠙⢿⣦⡀⠈⠀⠀⠈⣿",
        "⠈⠙⠷⢶⡆⠀⠀⢹⡇⠀⠀⠀⠀⠀⢸⣿⠿⠦⣴⣧⣤⣼⠷⠾⠟⣿⠇⠀⠀⠀⠀⢠⡟⠀⠀⢰⣶⠾⠋",
        "⠀⠀⠀⠈⢿⣤⣤⡾⠃⠀⠀⠀⠀⠀⠀⠻⣦⡀⠀⠀⠀⠀⠀⣀⣼⠏⠀⠀⠀⠀⠀⠈⢿⣤⣤⣾⠏⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠷⢶⣤⡶⠾⠋⠁⠀⠀           ⠀",
      }

      -- Set menu
      dashboard.section.buttons.val = {
        dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
        dashboard.button("SPC sf", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
        dashboard.button("SPC s.", "  > Recent files", "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("q", "󰅚 Quit NVIM", "<cmd>qa<CR>"),
      }

      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8

      return dashboard
    end,
    config = function(_, dashboard)
      require("alpha").setup(dashboard.opts)
      -- Disable folding on alpha buffer
      vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
    end,
  },

  -- [lualine](https://github.com/nvim-lualine/lualine.nvim)
  --
  -- Plugin to customize Neovim's Statusline
  --
  -- TODO: Need to checkout [galaxyline](https://github.com/NTBBloodbath/galaxyline.nvim)
  -- (or) customize lualine itself.
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "tokyonight",
        globalstatus = true,
      },
    },
  },

  -- Color Schemes for Neovim

  -- [catppuccin](https://github.com/catppuccin/nvim)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- Make sure to load this before all the other start plugins.
    priority = 1000,
    opts = {
      -- disables setting the background color.
      transparent_background = true,
      -- enable transparent floating windows
      float = { transparent = true },
      -- shows the "~" characters after the end of buffers
      show_end_of_buffer = true,
      -- dims the background color of inactive window
      dim_inactive = { enabled = true },
    },
  },

  -- [ellisonleao's Gruvbox lua Port](https://github.com/ellisonleao/gruvbox.nvim)
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = {
      dim_inactive = true,
      transparent_mode = true,
    },
  },

  -- [Folke's tokyonight](https://github.com/folke/tokyonight.nvim)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- Enable this to disable setting the background color
      transparent = true,
      -- dims inactive windows
      dim_inactive = true,
      styles = {
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
      },
    },
    init = function()
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },
}
