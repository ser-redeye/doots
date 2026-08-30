-- Plugins that manage and make my notemaking experience in neovim better

return {
  -- [render-markdown](https://github.com/MeanderingProgrammer/render-markdown.nvim)
  --
  -- Provides Nice visuals for Markdown Rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      -- Filetypes this plugin will run on.
      file_types = { "markdown", "codecompanion" },
      heading = {
        position = "inline",
        width = "block",
        left_pad = 2,
        right_pad = 4,
        border = true,
        below = "—",
        above = "",
      },
      code = { language_pad = 2, left_pad = 1, right_pad = 1 },
      -- No customizations, I like the defaults
      -- dash = {},
      bullet = { icons = { "∙", "∘", "", "" }, right_pad = 1 },
      checkbox = {
        position = "inline",
        -- [Inspired by Things theme in obsidian](https://github.com/colineckert/obsidian-things/raw/main/assets/checkbox-styles.png)
        custom = {
          incomplete = {
            raw = "[/]",
            rendered = " ",
            highlight = "RenderMarkdownIncomplete",
          },
          canceled = {
            raw = "[-]",
            rendered = " ",
            highlight = "RenderMarkdownCanceled",
          },
          forwarded = {
            raw = "[>]",
            rendered = " ",
            highlight = "RenderMarkdownForwarded",
          },
          scheduling = {
            raw = "[<]",
            rendered = " ",
            highlight = "RenderMarkdownScheduling",
          },
          question = {
            raw = "[?]",
            rendered = " ",
            highlight = "RenderMarkdownQuestion",
          },
          important = {
            raw = "[!]",
            rendered = " ",
            highlight = "RenderMarkdownImportant",
          },
          star = {
            raw = "[*]",
            rendered = " ",
            highlight = "RenderMarkdownStar",
          },
          quote = {
            raw = '["]',
            rendered = " ",
            highlight = "RenderMarkdownQuote",
          },
          location = {
            raw = "[l]",
            rendered = " ",
            highlight = "RenderMarkdownLocation",
          },
          bookmark = {
            raw = "[b]",
            rendered = " ",
            highlight = "RenderMarkdownBookmark",
          },
          -- information & idea cant coexist as both use the same letter 'i'
          -- information = {
          --   raw = '[i]',
          --   rendered = ' ',
          --   highlight = 'RenderMarkdownInformation'
          -- },
          savings = {
            raw = "[S]",
            rendered = " ",
            highlight = "RenderMarkdownSavings",
          },
          idea = {
            raw = "[I]",
            rendered = " ",
            highlight = "RenderMarkdownIdea",
          },
          pros = {
            raw = "[p]",
            rendered = " ",
            highlight = "RenderMarkdownPros",
          },
          cons = {
            raw = "[c]",
            rendered = " ",
            highlight = "RenderMarkdownCons",
          },
          fire = {
            raw = "[f]",
            rendered = " ",
            highlight = "RenderMarkdownFire",
          },
          key = {
            raw = "[k]",
            rendered = " ",
            highlight = "RenderMarkdownKey",
          },
          win = {
            raw = "[w]",
            rendered = " ",
            highlight = "RenderMarkdownWin",
          },
          up = {
            raw = "[u]",
            rendered = " ",
            highlight = "RenderMarkdownUp",
          },
          down = {
            raw = "[d]",
            rendered = " ",
            highlight = "RenderMarkdownDown",
          },
        },
      },
      quote = { repeat_linebreak = true },
      -- TODO: I haven't used alot of tables, might need to revisit later
      -- No customizations
      -- pipe_table = {},

      -- No customizations, Maybe i might add some custom callout types?
      -- callout = {},    -- Filetypes this plugin will run on.

      -- No customizations, Maybe i might add some custom web icons?
      -- link = {},
      sign = { enabled = false },
      -- No customizations, I dont prefer org-indent-mode.
      -- indent = {},
    },
  },

  -- [Obsidian](https://github.com/obsidian-nvim/obsidian.nvim)
  --
  -- Writing and navigating notes in Obsidian vaults
  {
    "obsidian-nvim/obsidian.nvim",
    -- Use latest release instead of latest commit
    version = "*",
    ft = "markdown",
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      legacy_commands = false,
      workspaces = {
        {
          name = "notes",
          path = "~/[01] Chamber of Wisdom/",
        },
      },
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- E.G.; If a note is created with a title 'My new notes'.
      --       File Name would be '1657296016-my-new-note.md'
      note_id_func = function(title)
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,
    },
  },
}
