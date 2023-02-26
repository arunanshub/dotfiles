local M = {}

-- disabled keybindings
M.disabled = {
  n = {
    ["<S-Tab>"] = "",
    ["<leader>f"] = "",
  }
}

-- neovim related keybindings
M.general = {
  n = {
    [";"] = {":", "enter command mode", opts = { nowait = true }},
    ["<C-L>"] = {"<cmd>nohl <CR>", "clear highlights"},
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
    ["<TAB>"] = {"<cmd> silent! Telescope git_files <CR>", "show git files"},
    ["gr"] = {"<cmd> Telescope lsp_references <CR>", "Find references"},
    ["<leader>q"] = {"<cmd> Telescope diagnostics <CR>", "Show workspace diagnostics"},
    ["<leader>s"] = {"<cmd> Telescope lsp_document_symbols <CR>", "Show document symbols"},
  },
}

return M
