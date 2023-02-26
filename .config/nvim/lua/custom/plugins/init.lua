return {
  ["tpope/vim-abolish"] = {},

  ["tpope/vim-surround"] = {},

  ["Vimjas/vim-python-pep8-indent"] = { ft = { "python" } },

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  --  ["hrsh7th/nvim-cmp"] = {
  --   override_options = function()
  --     local cmp = require "cmp"
  --
  --     return {
  --       mapping = cmp.mapping.preset.insert {
  --         ["<CR>"] = cmp.mapping.confirm {
  --           behavior = cmp.ConfirmBehavior.Replace,
  --           select = true,
  --         },
  --       },
  --     }
  --   end,
  -- },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },

  ["williamboman/mason.nvim"] = {
    override_options = {
      ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev
        "html-lsp",
        "css-lsp",
        "emmet-ls",
        "prettier",
        -- "typescript-language-server",
        -- "deno",
        -- "cssls",
        -- "tsserver",
        -- "tailwindcss",
        -- "emmet_ls",

        -- python
        "pyright",
        "black",
        "isort",

        -- C/C++
        "clangd",
        "clang-format",

        -- Go
        "gopls",

        "jdtls",
        -- "rust-analyzer",
        -- "html",
        -- "vimls",

        -- sphinx
        "esbonio",

        -- config files
        -- "taplo",
        -- "yamlls",
        -- "json-lsp",
        -- "dockerls",

        -- shell
        "shfmt",
        "shellcheck",
        "bash-language-server",
      },
    },
  },

  ["nvim-telescope/telescope.nvim"] = {
    override_options = function()
      -- close telescope on escape
      local actions = require "telescope.actions"
      return {
        defaults = {
          mappings = {
            i = { ["<esc>"] = actions.close },
          },
        },
      }
    end,
  },

  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = {
      ensure_installed = {
        "python",
        "rust",
        "c",
        "cpp",
        "bash",
        "go",
        "gomod",
        "html",
        "toml",
        "lua",
        "yaml",
        "rst",
        "json",
        "dockerfile",
        "meson",
        "ninja",
        "markdown",
      },
      indent = {
        enable = false,
      },
    },
  },
}
