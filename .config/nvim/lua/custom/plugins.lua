local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {
  { "tpope/vim-abolish", lazy = false },

  { "tpope/vim-surround", lazy = false },

  { "tpope/vim-eunuch", lazy = false },

  {
    "Vimjas/vim-python-pep8-indent",
    ft = { "python" },
  },

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = overrides.nvim_cmp,
  },

  {
    "numToStr/Comment.nvim",
    keys = { "gc" },
  },
}

return plugins
