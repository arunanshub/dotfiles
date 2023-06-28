local M = {}

-- disabled keybindings
M.disabled = {
  n = {
    ["<tab>"] = "",
    ["<S-tab>"] = "",
    ["<leader>f"] = "",
  },
}

-- neovim related keybindings
M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    ["<leader>d"] = {
      function()
        vim.diagnostic.open_float()
      end,
      "floating diagnostic",
    },
  },
}

-- telescope related keybindings
M.telescope = {
  n = {
    ["<Tab>"] = { "<cmd> silent! Telescope git_files <CR>", "show git files" },
    ["gr"] = { "<cmd> Telescope lsp_references <CR>", "Find references" },
    ["gd"] = { "<cmd> Telescope lsp_definitions <CR>", "Find definitions" },
    ["<leader>q"] = { "<cmd> Telescope diagnostics <CR>", "Show workspace diagnostics" },
    ["<leader>s"] = { "<cmd> Telescope lsp_document_symbols <CR>", "Show document symbols" },
    ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "Keymaps" },
    ["<leader>fe"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Fuzzy find in current buffer" },
  },

  v = {
    ["<leader>ca"] = { "<cmd> lua vim.lsp.buf.code_action() <CR>", "perform code action" },
  },
}

return M
