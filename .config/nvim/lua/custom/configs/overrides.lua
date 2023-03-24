local M = {}

M.treesitter = {
  ensure_installed = {
    -- general langs
    "python",
    "rust",
    "c",
    "cpp",
    "lua",
    "go",

    -- configs
    "gomod",
    "yaml",
    "toml",
    "json",
    "ninja",
    "meson",

    -- shell
    "bash",

    -- docs
    "markdown",
    "markdown_inline",
    "rst",

    -- docker
    "dockerfile",

    -- webdev
    "javascript",
    "typescript",
    "html",
    "vue",
  },
  indent = {
    enable = true,
    disable = {
      "python",
    },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev
    "html-lsp",
    "css-lsp",
    "emmet-ls",
    "prettier",
    "typescript-language-server",
    "json-lsp",
    -- "deno",
    -- "tailwindcss",

    -- python
    "pyright",
    "black",
    "isort",

    -- C/C++
    "clangd",
    "clang-format",

    -- Go
    "gopls",
    "gofumpt",
    "goimports-reviser",

    -- java
    "jdtls",
    -- "rust-analyzer",
    -- "vimls",

    -- sphinx
    "esbonio",

    -- docker
    "dockerfile-language-server",
    "docker-compose-language-service",

    -- shell
    "shfmt",
    "shellcheck",
    "bash-language-server",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

-- local actions = require "telescope.actions"
-- M.telescope = function(_, opts)
--   opts = vim.tbl_deep_extend("force", opts, {
--     defaults = {
--       mappings = {
--         i = { ["<esc>"] = require("telescope.actions").close },
--       },
--     },
--   })
--   return opts
-- end

M.telescope = {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = function(...)
          require("telescope.actions").close(...)
        end,
      },
    },
  },
}

M.nvim_cmp = {
  completion = {
    completeopt = "menu,menuone,noselect",
  },
}

return M
