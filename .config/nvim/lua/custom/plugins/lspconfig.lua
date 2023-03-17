local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  -- web dev stuff
  "html",
  "cssls",
  "emmet_ls",
  "jsonls",
  "volar",

  -- languages
  "clangd",
  "pyright",
  "gopls",
  "jdtls",
  "tsserver",
  "zls",

  -- docker
  "dockerls",
  "docker_compose_language_service",

  -- shell
  "bashls",
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
