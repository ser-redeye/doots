-- Auto-Completion setup in Neovim

return {

  -- [blink.cmp](https://github.com/Saghen/blink.cmp)
  --
  -- completion plugin with support for LSPs, cmdline, signature help
  -- and snippets.

  {
    "saghen/blink.cmp",
    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- optional: provides snippets for the snippet source
    dependencies = { "rafamadriz/friendly-snippets" },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = "default" },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}

-- I am storing my old completion as i still havent completely configured blink.
-- Might need this for reference.
-- return {
--   'hrsh7th/nvim-cmp',
--   event = 'InsertEnter',
--   dependencies = {
--     -- Snippet Engine
--     {
--       'L3MON4D3/LuaSnip',
--       build = (function()
--         -- Build Step is needed for regex support in snippets.
--         --   This step is not supported in many windows environments.
--         --   Remove the below condition to re-enable on windows.
--         if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
--           return
--         end
--         return 'make install_jsregexp'
--       end)(),
--       dependencies = {
--         -- `friendly-snippets` contains a variety of premade snippets.
--         --    See the README on individual language/framework/plugin snippets:
--         --    https://github.com/rafamadriz/friendly-snippets
--         {
--           'rafamadriz/friendly-snippets',
--           config = function()
--             require('luasnip.loaders.from_vscode').lazy_load()
--           end,
--         },
--       },
--     },

--     -- provides icons for completions
--     'onsails/lspkind.nvim',

--     -- nvim-cmp completion sources
--     'saadparwaiz1/cmp_luasnip',
--     'hrsh7th/cmp-nvim-lsp',
--     'hrsh7th/cmp-path',
--     'hrsh7th/cmp-buffer',
--     'chrisgrieser/cmp_yanky',
--   },
--   config = function()
--     -- See `:help cmp`
--     local cmp = require 'cmp'
--     local luasnip = require 'luasnip'
--     local lspkind = require 'lspkind'

--     luasnip.config.setup {}

--     cmp.setup {
--       snippet = {
--         expand = function(args)
--           luasnip.lsp_expand(args.body)
--         end,
--       },
--       completion = { completeopt = 'menu,menuone,preview,noselect' },

--       -- TODO: Read this
--       -- For an understanding of why these mappings were
--       -- chosen, you will need to read `:help ins-completion`
--       -- No, seriously. Please read `:help ins-completion`, it's really good!
--       mapping = cmp.mapping.preset.insert {
--         -- Select the [n]ext item
--         ['<C-n>'] = cmp.mapping.select_next_item(),
--         -- Select the [p]revious item
--         ['<C-p>'] = cmp.mapping.select_prev_item(),

--         -- Scroll the documentation window [b]ack / [f]orward
--         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-f>'] = cmp.mapping.scroll_docs(4),

--         -- Accept ([y]es) the completion.
--         --  This will auto-import if your LSP supports it.
--         --  This will expand snippets if the LSP sent a snippet.
--         ['<C-y>'] = cmp.mapping.confirm { select = true },

--         -- Close completion window
--         ['<C-e>'] = cmp.mapping.abort(),

--         -- Manually trigger a completion from nvim-cmp.
--         --  Generally you don't need this, because nvim-cmp will display
--         --  completions whenever it has completion options available.
--         ['<C-Space>'] = cmp.mapping.complete {},

--         -- Think of <c-l> as moving to the right of your snippet expansion.
--         --  So if you have a snippet that's like:
--         --  function $name($args)
--         --    $body
--         --  end
--         --
--         -- <c-l> will move you to the right of each of the expansion locations.
--         -- <c-h> is similar, except moving you backwards.
--         ['<C-l>'] = cmp.mapping(function()
--           if luasnip.expand_or_locally_jumpable() then
--             luasnip.expand_or_jump()
--           end
--         end, { 'i', 's' }),
--         ['<C-h>'] = cmp.mapping(function()
--           if luasnip.locally_jumpable(-1) then
--             luasnip.jump(-1)
--           end
--         end, { 'i', 's' }),

--         -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
--         --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
--       },
--       sources = {
--         { name = 'lazydev',  group_index = 0 }, -- set group index to 0 to skip loading LuaLS completions
--         { name = 'nvim_lsp' },
--         { name = 'luasnip' },
--         { name = "cmp_yanky" },
--         {
--           name = 'buffer',
--           option = {
--             indexing_interval = 50,
--             indexing_batch_size = 1500,
--             get_bufnrs = function()
--               local buf = vim.api.nvim_get_current_buf()
--               local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
--               if byte_size > 1024 * 1024 then -- 1 Megabyte max
--                 return {}
--               end
--               return { buf }
--             end,
--           },
--         },
--         { name = 'path' },
--       },

--       formatting = {
--         format = lspkind.cmp_format {
--           -- prevent the popup from showing more characters
--           maxwidth = function()
--             return math.floor(0.45 * vim.o.columns)
--           end,
--           ellipsis_char = '...',
--         },
--       },
--     }
--   end,
-- }
--
-- return {
--   'windwp/nvim-autopairs',
--   event = { 'InsertEnter' },
--   dependencies = {
--     'hrsh7th/nvim-cmp',
--   },
--   opts = {
--     check_ts = true, -- enable treesitter
--     ts_config = {
--       lua = { 'string' }, -- don't add pairs in lua string treesitter nodes
--       javascript = { 'template_string' }, -- don't add pairs in javscript template_string treesitter nodes
--       java = false, -- don't check treesitter on java
--     },
--   },
--   init = function()
--     -- make autopairs and completion work together
--     local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
--     require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
--   end,
-- }
