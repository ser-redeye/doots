-- Package Manager for Neovim utilities

return {

  -- [Mason](https://github.com/mason-org/mason.nvim)
  --
  -- Portable package manager for Neovim that runs everywhere Neovim runs.
  -- Install and manage LSP servers, DAP servers, linters, and formatters.
  --
  -- Usefull Commands available:
  -- :Mason                        - opens a graphical status window
  -- :MasonUpdate                  - updates all managed registries
  -- :MasonInstall <package> ...   - installs/re-installs the provided packages
  -- :MasonUninstall <package> ... - uninstalls the provided packages
  -- :MasonUninstallAll            - uninstalls all packages
  -- :MasonLog                     - opens the mason.nvim log file in a
  --                                 new tab window

  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      ---@since 1.0.0
      -- Controls to which degree logs are written to the log file. Set to
      -- vim.log.levels.DEBUG to debug package installations failures.
      log_level = vim.log.levels.INFO,
    },
    -- HACK: Refer to [Mason's PR#3900](https://github.com/mason-org/mason-registry/pull/3900)
    -- I use mdformat, a CommonMark formatter. It doesn’t have out-of-the-box
    -- support for syntax other than what is defined in the CommonMark Spec.
    -- Extra support for GitHub Flavored Markdown (GFM) or YAML front matter
    -- or any other extension as mentioned in the [Documentation](https://mdformat.readthedocs.io/en/stable/users/plugins.html)
    -- can be added by installing these plugins in the environment.
    -- ...
    -- Installing these plugins as sub-package for mdformat in Mason is NOT
    -- SUPPORTED yet. Once its done, need to remove this hack.
    config = function(_, opts)
      require("mason").setup(opts)

      local registry_status_ok, mason_registry = pcall(require, "mason-registry")
      if not registry_status_ok then
        return
      end

      mason_registry.refresh(function()
        local mdformat = mason_registry.get_package("mdformat")
        local mdformat_extensions = {
          "mdformat-frontmatter",
          -- 'mdformat-gfm',
          -- 'mdformat-toc',
          -- 'mdformat-myst',
        }
        mdformat:on("install:success", function()
          -- Create the installation command.
          vim.notify("Installing mdformat extensions.")
          local extensions = table.concat(mdformat_extensions, " ")
          local mdformat_path = require("mason-core.installer.InstallLocation").global():package("mdformat")
          local python
          if vim.loop.os_uname().sysname:match("Windows") then
            python = mdformat_path .. "/venv/Scripts/python.EXE"
          else
            python = mdformat_path .. "/venv/bin/python"
          end
          local pip_cmd = string.format("%s -m pip install %s", python, extensions)

          local handle = io.popen(pip_cmd)
          if not handle then
            vim.notify('Could not install "mdformat extensions".', vim.log.levels.ERROR)
            return
          end
          local _ = handle:read("*a")
          handle:close()

          vim.notify('"mdformat extensions" were successfully installed.')
        end)
      end)
    end,
  },

  -- [mason-tool-installer](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)
  --
  -- Install or upgrade all of your third-party tools using mason

  -- Usefull Commands available:
  -- :MasonToolsInstall     - only installs tools that are missing or at the
  --                          incorrect version
  -- :MasonToolsInstallSync - execute :MasonToolsInstall in blocking manner.
  --                          It's useful in Neovim headless mode.
  -- :MasonToolsUpdate      - install missing tools and update already
  --                          installed tools
  -- :MasonToolsUpdateSync  - execute :MasonToolsUpdate in blocking manner.
  --                          It's useful in Neovim headless mode.
  -- :MasonToolsClean       - remove installed packages that are not listed
  --                          in ensure_installed

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- a list of all tools you want to ensure are installed on start-up
      ensure_installed = {
        -- LSPs
        "clangd",
        "lua-language-server",
        "marksman",
        "rust-analyzer",
        -- DAPs
        -- Linters
        "markdownlint-cli2", -- Markdown Linter, needs NPM
        -- Formatters
        "stylua", -- lua formatter
        "mdformat", -- Markdown formatter, needs python

        -- you can do conditional installing
        -- { 'gopls', condition = function() return vim.fn.executable('go') == 1  end },
      },
    },
  },
}
