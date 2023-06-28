local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  -- web dev stuff
  "html",
  "cssls",
  -- "emmet_ls",
  "jsonls",
  "astro",
  "volar",

  -- languages
  "clangd",
  "pyright",
  "gopls",
  "jdtls",
  -- "tsserver",
  "zls",

  -- docker
  "dockerls",

  -- config files
  -- "yamlls",
  "taplo",

  -- shell
  "bashls",

  -- prisma db
  "prismals",

  -- markdown
  "marksman",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- sphinx documentation
lspconfig["esbonio"].setup {
  cmd = { "esbonio" },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- docker-compose lsp
lspconfig["docker_compose_language_service"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig["volar"].setup {
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "json",
  },
  -- on_attach = on_attach,
  on_attach = function(client, ...)
    client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
    return on_attach(client, ...)
  end,
  capabilities = capabilities,
}

-- lspconfig["unocss"].setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

lspconfig["tsserver"].setup {
  filetypes = { "javascript" },
  on_attach = on_attach,
  capabilities = capabilities,
}
