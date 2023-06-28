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

    -- prisma and sql
    "prisma",
    "sql",
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
    "prettierd",
    "typescript-language-server",
    "vue-language-server",
    "json-lsp",
    "deno",
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

    -- yaml
    "yamlfmt",
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

M.nvim_cmp = function(_, opts)
  local cmp = require "cmp"

  opts = vim.tbl_deep_extend("force", opts, {
    mapping = {
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
    },
    completion = {
      completeopt = "menu,menuone,noselect",
    },
    preselect = cmp.PreselectMode.NONE,
  })
  return opts
end

return M
