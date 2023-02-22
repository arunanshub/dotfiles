local M = {}

-- disabled keybindings
M.disabled = {
  n = {
    ["<S-Tab>"] = "",
  }
}

-- neovim related keybindings
M.general = {
  n = {
    [";"] = {":", "enter command mode", opts = { nowait = true }},
    ["<C-L>"] = {"<cmd>nohl <CR>", "clear highlights"},
  },
}

-- telescope related keybindings
M.telescope = {
  plugin = true,

  n = {
    ["<TAB>"] = {"<cmd> Telescope git_files <CR>", "show git files"},
    ["gr"] = {"<cmd> Telescope lsp_references <CR>", "Find references"},
  },
}

return M
