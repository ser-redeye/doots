-- [nvim-lint](https://github.com/mfussenegger/nvim-lint)
--
-- Asynchronous linter plugin.
--
-- Shortcuts available:
-- <leader>l - Trigger linting for current buffer
--
-- Linter gets triggered automatically after entering a buffer,
--   leaving insert mode and after saving a buffer.

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      markdown = { "markdownlint-cli2" },
    }

    -- Per Linter configuration
    -- Markdown - markdownlint_cli2
    local markdownlint_cli2 = lint.linters["markdownlint-cli2"]
    local config_dir = os.getenv("XDG_CONFIG_HOME") or (vim.fn.expand("~") .. "/.config")
    markdownlint_cli2.args = { "--config", config_dir .. "/markdownlint-cli2.yaml", "--" }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
