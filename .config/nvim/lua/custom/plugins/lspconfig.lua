local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local servers = {
  -- web dev stuff
  "html",
  "cssls",
  "emmet_ls",

  -- languages
  "clangd",
  "pyright",
  "gopls",
  "jdtls",

  -- sphinx shit
  "esbonio",

  -- shell
  "bashls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
