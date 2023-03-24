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

  -- config files
  -- "yamlls",
  "taplo",

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

-- docker-compose lsp
lspconfig["docker_compose_language_service"].setup {
  -- root_dir = lspconfig.util.root_pattern("compose.y*ml", "docker-compose.y*ml"),
  -- single_file_support = false,
  on_attach = on_attach,
  capabilities = capabilities,
}
