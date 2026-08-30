-- Git plugins for Neovim

return {

  -- [gitsigns](https://github.com/lewis6991/gitsigns.nvim)
  --
  -- Git decorations and usefull commands

  -- Shortcuts available:
  -- [h                   - Navigate to previous hunk
  -- ]h                   - Navigate to next hunk
  -- <leader>hs           - Stage hunk
  --
  -- Commands available:
  -- :Gitsigns setqflist  - Populate and open quickfix list with hunks
  -- :Gitsigns setloclist - Populate and open location list with hunks

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "┃" }, -- green
        change = { text = "┃" }, -- yellow
        delete = { text = "_" }, -- red
        topdelete = { text = "‾" }, -- red
        changedelete = { text = "~" }, -- yellow
        untracked = { text = "┆" }, -- green
      },
      signs_staged = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      -- as attach() does a lot of checks to make sure the buffer is attachable
      -- Default(false), Issue #63
      attach_to_untracked = false,
      -- Toggle with `:Gitsigns toggle_current_line_blame` or <leader>hB
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 3000,
      },
      current_line_blame_formatter = " <author>, <author_time:%R>",
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        -- TODO: In diff mode, config guide says to not override it.
        --   if vim.wo.diff then vim.cmd.normal({']c', bang = true})
        map("n", "[h", function()
          gs.nav_hunk("prev")
        end, "Prev Hunk")
        map("n", "]h", function()
          gs.nav_hunk("next")
        end, "Next Hunk")

        -- Actions
        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage hunk")
        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset hunk")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, "Blame line")
        map("n", "<leader>hB", gs.blame, "Blame for current buffer in v-split")
        -- TODO: What's the diff btw these two maps
        map("n", "<leader>hd", gs.diffthis, "Diff this")
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, "Diff this ~")

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
      end,
    },
  },

  -- [Neogit](https://github.com/NeogitOrg/neogit)
  --
  -- An interface for git operations in Neovim

  -- Usefull Shortcuts available:
  -- <leader>go          - Open neogit interface, equivalent to :Neogit command
  --
  -- Usefull Commands available:
  -- :Neogit             - Open the status buffer in a new tab *neogit.open()*
  -- :Neogit cwd=<cwd>   - Use a different repository path
  -- :Neogit cwd=%:p:h   - Uses the repository of the current file
  -- :Neogit kind=<kind> - Open specified popup directly
  -- :Neogit commit      - Open commit popup

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
    keys = {
      { "<leader>go", "<cmd>Neogit<CR>", desc = "Neo[G]it Open Interface" },
    },
  },
}
