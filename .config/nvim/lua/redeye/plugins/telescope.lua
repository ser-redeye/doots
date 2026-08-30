-- Versatile Fuzzy Finder utility
return {
  "nvim-telescope/telescope.nvim",
  tag = "v0.1.9",
  cmd = "Telescope",
  event = "VimEnter",
  enabled = true,
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      enabled = true,
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    { "debugloop/telescope-undo.nvim" },
    { "ghassan0/telescope-glyph.nvim" },
  },
  config = function()
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local make_entry = require("telescope.make_entry")
    local utils = require("telescope.utils")
    local telescope_utils = {}

    telescope_utils.open_with_trouble = function(...)
      return require("trouble.sources.telescope").open(...)
    end

    telescope_utils.find_files_with_ignore = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      builtin.find_files({ no_ignore = true, default_text = line })
    end

    telescope_utils.find_files_with_hidden = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      builtin.find_files({ hidden = true, default_text = line })
    end

    telescope_utils.find_command = function()
      if 1 == vim.fn.executable("fd") then
        return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("rg") then
        return { "rg", "--files", "--color", "never", "-g", "!.git" }
      elseif 1 == vim.fn.executable("fdfind") then
        return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
        return { "find", ".", "-type", "f" }
      elseif 1 == vim.fn.executable("where") then
        return { "where", "/r", ".", "*" }
      end
    end

    --- Search for files using git_files with find_files as fallback
    --- @param opts table: contains key-value pairs for arguments
    --   - use_find_files boolean: use find_files picker (default: false)
    telescope_utils.find_files_enhanced = function(opts)
      opts = opts or {}
      opts.use_find_files = opts.use_find_files or false

      -- We cache the results of "git rev-parse"
      -- Process creation is expensive in Windows, so this reduces latency
      local cwd = vim.fn.getcwd()
      if telescope_utils.is_inside_git_work_tree[cwd] == nil then
        vim.fn.system("git rev-parse --is-inside-work-tree")
        telescope_utils.is_inside_git_work_tree[cwd] = vim.v.shell_error == 0
      end

      if opts.use_find_files == true or not telescope_utils.is_inside_git_work_tree[cwd] then
        require("telescope.builtin").find_files()
      else
        require("telescope.builtin").git_files({ show_untracked = true })
      end
    end
    telescope_utils.is_inside_git_work_tree = {}

    -- TODO: Desc for mappings is broken, fix available from #2892
    -- Add Desc when it's pushed to stable release 0.1.x
    require("telescope").setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "truncate" },
        -- winblend = 10,
        preview = { filesize_limit = 3 }, -- 2 MB max for file preview
        default_mappings = {
          n = {
            -- DEFAULTS
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<esc>"] = actions.close,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            -- CUSTOM
            ["<C-/>"] = actions.which_key,
            ["<C-_>"] = actions.which_key,
            ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
          },
          i = {
            -- DEFAULTS
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-c>"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-h>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            ["<M-u>"] = actions.results_scrolling_up,
            ["<M-d>"] = actions.results_scrolling_down,
            ["<C-/>"] = actions.which_key,
            -- TODO: Why do i need this key?
            -- keys from pressing <C-/>
            ["<C-_>"] = actions.which_key,
            ["<C-w>"] = { "<c-s-w>", type = "command" },
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            -- disable c-j, New lines not allowed #2123
            ["<C-j>"] = actions.nop,
            -- CUSTOM
            ["<M-t>"] = telescope_utils.open_with_trouble, -- Opens selection(or everything) in trouble
          },
        },
        layout_config = {
          horizontal = { width = 0.9, height = 0.9, preview_width = 0.5 },
          vertical = { width = 0.9, height = 0.9 },
        },
      },
      pickers = {
        current_buffer_fuzzy_find = {
          previewer = false,
        },
        buffers = {
          sort_mru = true,
          sort_lastused = true,
        },
        builtin = {
          include_extensions = true,
        },
        git_files = {
          mappings = {
            n = {
              -- CUSTOM
              ["<M-f>"] = function()
                telescope_utils.find_files_enhanced({ use_find_files = true })
              end,
            },
          },
        },
        oldfiles = {
          mappings = {
            n = {
              -- CUSTOM
              ["<M-.>"] = function()
                builtin.oldfiles({ cwd = vim.uv.cwd() })
              end,
            },
          },
        },
        find_files = {
          find_command = telescope_utils.find_command,
          mappings = {
            n = {
              -- CUSTOM
              ["<M-i>"] = telescope_utils.find_files_with_ignore,
              ["<M-.>"] = telescope_utils.find_files_with_hidden,
            },
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
        undo = {
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.7,
          },
          mappings = {
            i = {
              ["<cr>"] = require("telescope-undo.actions").yank_additions,
              ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
              ["<C-r>"] = require("telescope-undo.actions").restore,
              -- Remove Defaults
              ["<S-cr>"] = false,
              ["<C-cr>"] = false,
            },
            n = {
              -- Remove Defaults
              ["y"] = false,
              ["Y"] = false,
              ["u"] = false,
            },
          },
        },
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "session-lens")
    pcall(require("telescope").load_extension, "ui-select")
    pcall(require("telescope").load_extension, "undo")
    -- TODO: Figure out how to yank and paste selection
    pcall(require("telescope").load_extension, "glyph")

    -- Keymap Util Functions
    local live_grep_func = function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end

    -- Keymappings for telescope
    vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sf", telescope_utils.find_files_enhanced, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader><leader>", builtin.resume, { desc = "[S]earch [R]esume" })
    vim.keymap.set("n", "<leader>su", require("telescope").extensions.undo.undo, { desc = "[S]earch [U]ndo tree" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>sr", builtin.oldfiles, { desc = "[S]earch Recent Files)" })
    vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[ ] Find existing buffers" })
    vim.keymap.set("n", "<leader>sm", builtin.man_pages, { desc = "[S]earch [M]an pages" })
    vim.keymap.set("n", "<leader>sc", builtin.command_history, { desc = "[S]earch [C]ommand history" })
    vim.keymap.set(
      "n",
      "<leader>/",
      builtin.current_buffer_fuzzy_find,
      { desc = "[/] Fuzzily search in current buffer" }
    )
    vim.keymap.set("n", "<leader>s/", live_grep_func, { desc = "[S]earch [/] in Open Files" })
  end,
}
