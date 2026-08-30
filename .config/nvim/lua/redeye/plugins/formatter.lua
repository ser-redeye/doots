-- [Conform](https://github.com/stevearc/conform.nvim)
--
-- Formatter plugin
--
-- Shortcuts available:
-- <leader>f - Add current file to harpoon list
--
-- Commands available:
-- :ConformInfo => Opens a buffer contains a snippet of the log file,
--   the location of the log file (gf to jump to the logfile),
--   available formatters for the current buffer,
--   and a list of all the configured formatters.
--   NOTE: Before debugging, besure to change the log_level to
--   vim.log.levels.ERROR or vim.log.levels.TRACE (logs inputs & outputs)

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },

  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local filetype = vim.bo[bufnr].filetype
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style.
      local disable_lsp_fallback = { c = true, cpp = true, markdown = true }
      -- I don't want format_on_save for the following filetypes
      local disable_filetypes = { "markdown" }

      if vim.tbl_contains(disable_filetypes, filetype) then
        return nil
      end

      return {
        timeout_ms = 500,
        lsp_fallback = not disable_lsp_fallback[filetype],
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      markdown = { "mdformat" },
    },
    -- Set the log level. Use `:ConformInfo` to see the location of the log file.
    log_level = vim.log.levels.ERROR,
  },
}
