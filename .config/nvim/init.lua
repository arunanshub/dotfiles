-- vim: fdm=marker:
--[[
File: init.lua
Author: Arunanshu Biswas (@arunanshub)
Description: A `init.lua` for the IDE beauty. Make sure you atleast have node
installed.
]]

-- Install packer {{{1
local install_path = vim.fn.stdpath "data"
    .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute(
        "!git clone https://github.com/wbthomason/packer.nvim " .. install_path
    )
end

vim.cmd [[
augroup packer_user_config
  autocmd!
  autocmd BufWritePost init.lua source <afile> | :PackerCompile
augroup end
]]
-- 1}}}

-- Plugins {{{1
local use = require("packer").use
require("packer").startup(function()
    -- Package manager (MUST!)
    use "wbthomason/packer.nvim"

    -- Fugitive-companion to interact with github
    -- use 'tpope/vim-rhubarb'

    -- Automatic tags management
    -- use 'ludovicchabant/vim-gutentags'

    -- Jump to any location specified by two characters
    -- use 'justinmk/vim-sneak'

    -- Add indentation guides even on blank lines
    use "lukas-reineke/indent-blankline.nvim"

    -- Highlight, edit, and navigate code using a fast incremental parsing library
    use "nvim-treesitter/nvim-treesitter"

    -- bracket autocompletion
    use "vim-scripts/auto-pairs-gentle"

    -- surround text with stuff
    use "tpope/vim-surround"

    -- sensible defaults
    use "tpope/vim-sensible"

    -- repeat a command
    use "tpope/vim-repeat"

    -- alignment of text
    use "junegunn/vim-easy-align"

    -- easy manipulation of text
    use "tpope/vim-abolish"

    -- useful mappings
    use "tpope/vim-unimpaired"

    -- editorconfig support for neovim
    use "editorconfig/editorconfig-vim"

    -- Tagbar
    use({ "majutsushi/tagbar", cmd = "TagbarOpenAutoClose" })

    -- Markdown syntax highlighting
    use({ "preservim/vim-markdown", ft = { "markdown" } })

    -- python indent fix
    use({ "Vimjas/vim-python-pep8-indent", ft = { "python" } })

    -- Auto formatting
    use({ "vim-autoformat/vim-autoformat", cmd = "Autoformat" })

    -- highlight instances of 'todo', 'fixme' etc.
    use({
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup()
        end,
    })

    -- "gc" to comment visual regions/lines
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    -- NOTE: colorscheme
    use({
        "navarasu/onedark.nvim",
        config = function()
            require("onedark").setup({
                style = "darker",
            })
            require("onedark").load()
        end,
    })

    -- Markdown preview in browser!
    use({
        "iamcco/markdown-preview.nvim",
        run = ":call mkdp#util#install()",
        ft = { "markdown", "packer" },
    })

    -- NOTE: statusline
    use({
        "nvim-lualine/lualine.nvim",
        requires = {
            "ryanoasis/vim-devicons",
            "arkav/lualine-lsp-progress",
        },
    })

    -- NOTE: File searcher (FZF)
    local cmd = { "Files", "BLines", "GFiles", "Rg" }
    use({
        "junegunn/fzf.vim",
        requires = {
            "junegunn/fzf",
            run = ":call fzf#install()",
            cmd = cmd,
        },
        cmd = cmd,
    })

    ---------------------- LSP section ----------------------
    -- quickstart config
    use "neovim/nvim-lspconfig"
    -- LSP customizations
    use "onsails/lspkind-nvim"
    -- LSP Server installer
    use({
        "williamboman/nvim-lsp-installer",
        requires = "neovim/nvim-lspconfig",
    })
    -- UI for LSP
    use({
        "tami5/lspsaga.nvim",
        requires = { "neovim/nvim-lspconfig" },
    })
    ---------------------------------------------------------

    --------------- Autocompletion section ------------------
    -- Autocompletion plugin
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
    })
    -- snippets
    use({
        "hrsh7th/cmp-vsnip",
        requires = {
            "hrsh7th/vim-vsnip",
            "rafamadriz/friendly-snippets",
        },
    })
    ---------------------------------------------------------

    ---------------------- Git section ----------------------
    -- Git signs
    use({
        "lewis6991/gitsigns.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("gitsigns").setup({
                yadm = { enable = true },
            })
            vim.cmd "nnoremap <F3> :Gitsigns preview_hunk<CR>"
        end,
    })
    -- Git commands in nvim
    use({ "tpope/vim-fugitive", cmd = { "G", "Git" } })
    ---------------------------------------------------------
end)
-- 1}}}

-- Neovim settings {{{1
-- fix tab and indent issues
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.smarttab = true

-- do not show the `--INSERT--` line
vim.o.showmode = false

--Make line numbers default
vim.wo.number = true

-- Show chars at the end of line
vim.opt.list = true

--Enable break indent
vim.o.breakindent = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- show the signcolumn (used by vim-signify)
vim.wo.signcolumn = "yes"

--Set 24 bit colors
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- performance
vim.o.hidden = true -- Enable background buffers
vim.o.history = 100 -- Remember N lines in history
vim.o.lazyredraw = true -- Faster scrolling
vim.o.synmaxcol = 240 -- Max column for syntax highlight
vim.o.updatetime = 400 -- ms to wait for trigger 'document_highlight'

-- Disable builtins plugins
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

--Remap for dealing with word wrap
vim.api.nvim_set_keymap(
    "n",
    "k",
    "v:count == 0 ? 'gk' : 'k'",
    { noremap = true, expr = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "j",
    "v:count == 0 ? 'gj' : 'j'",
    { noremap = true, expr = true, silent = true }
)

-- Highlight on yank
vim.cmd [[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]]

vim.cmd [[
cnoreabbrev W w
]]

vim.cmd [[
nnoremap <leader>p "+p
vnoremap <leader>y "+y
]]
-- 1}}}

-- Plugin settings {{{1

-- lspconfig and LSP installer {{{2
local SERVERS = {
    "bashls",
    "pyright",
    "rust_analyzer",
    "sumneko_lua",
    "html",
    "clangd",
    "vimls",
    "emmet_ls",
    "taplo", -- toml
    "yamlls",
    "dartls",
}

local lsp_installer = require "nvim-lsp-installer"
lsp_installer.setup({ ensure_installed = SERVERS })
local lspconfig = require "lspconfig"

-- Set up keymaps {{{3
local on_attach = function(_, bufnr)
    local function buf_set_keymap(...)
        vim.keymap.set(...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- jump to definition
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

    -- Format buffer
    -- buf_set_keymap('n', '<F3>', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    -- Jump LSP diagnostics
    -- NOTE: Currently, there is a bug in lspsaga.diagnostic module. Thus we use
    -- NOTE: Vim commands to move through diagnostics.
    buf_set_keymap("n", "[g", ":Lspsaga diagnostic_jump_prev<CR>", opts)
    buf_set_keymap("n", "]g", ":Lspsaga diagnostic_jump_next<CR>", opts)

    -- Rename symbol
    buf_set_keymap(
        "n",
        "<leader>rn",
        "<cmd>lua require('lspsaga.rename').rename()<CR>",
        opts
    )

    -- Find references
    buf_set_keymap(
        "n",
        "gr",
        '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>',
        opts
    )

    -- Doc popup scrolling
    buf_set_keymap(
        "n",
        "K",
        "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>",
        opts
    )
    buf_set_keymap(
        "n",
        "<C-f>",
        "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>",
        opts
    )
    buf_set_keymap(
        "n",
        "<C-b>",
        "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>",
        opts
    )

    -- codeaction
    buf_set_keymap(
        "n",
        "<leader>ac",
        "<cmd>lua require('lspsaga.codeaction').code_action()<CR>",
        opts
    )
    buf_set_keymap(
        "v",
        "<leader>a",
        ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>",
        opts
    )

    -- Floating terminal
    -- NOTE: Use `vim.cmd` since `buf_set_keymap` is not working with `tnoremap...`
    vim.cmd [[
  nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>
  tnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>
  ]]
end
-- 3}}}

-- server-specific options {{{3
local SERVER_SPECIFIC_OPTS = {
    clangd = function(opts)
        opts.cmd = {
            "clangd",
            "--clang-tidy",
        }
    end,
    pylsp = function(opts)
        opts.settings = {
            pylsp = {
                -- configurationSources = {"flake8"},
                plugins = {
                    jedi_completion = { include_params = true },
                    flake8 = { enabled = true },
                    pycodestyle = { enabled = false },
                },
            },
        }
    end,
    sumneko_lua = function(opts)
        opts.settings = {
            Lua = {
                -- NOTE: This is required for expansion of lua function signatures!
                runtime = { version = "LuaJIT" },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                completion = { callSnippet = "Replace" },
                diagnostics = {
                    globals = { "vim", "P" },
                },
            },
        }
    end,
    html = function(opts)
        opts.filetypes = { "html", "htmldjango" }
    end,
}
-- 3}}}

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

for _, server in ipairs(SERVERS) do
    local opts = {
        on_attach = on_attach,
        flags = { debounce_text_changes = 150 },
        capabilities = capabilities,
    }

    if SERVER_SPECIFIC_OPTS[server] then
        SERVER_SPECIFIC_OPTS[server](opts)
    end

    lspconfig[server].setup(opts)
end
-- 2}}}

-- nvim-cmp: Autocompletion plugin {{{2
local lspkind = require "lspkind"
local cmp = require "cmp"

local has_words_before = function()
    ---@diagnostic disable-next-line: deprecated
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
        and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
                :sub(col, col)
                :match "%s"
            == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(key, true, true, true),
        mode,
        true
    )
end

-- Fancy Autocompletion popup icons {{{3
local CMP_KINDS = {
    Class = "ﴯ",
    Color = "",
    Constant = "",
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "ﰠ",
    File = "",
    Folder = "",
    Function = "",
    Interface = "",
    Keyword = "",
    Method = "",
    Module = "",
    Operator = "",
    Property = "ﰠ",
    Reference = "",
    Snippet = "",
    Struct = "פּ",
    Text = "",
    TypeParameter = "",
    Unit = "塞",
    Value = "",
    Variable = "",
}
-- 3}}}

cmp.setup({
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            preset = "codicons",
            symbol_map = CMP_KINDS,
            menu = {
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[Latex]",
            },
        }),
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({
        { name = "vsnip" },
        { name = "nvim_lsp" },
    }, {
        { name = "buffer" },
    }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})
-- 2}}}

-- lspsaga
require("lspsaga").init_lsp_saga({
    finder_action_keys = {
        open = "<CR>",
        quit = { "q", "<esc>" },
    },
    code_action_keys = {
        quit = { "q", "<esc>" },
    },
    rename_action_keys = {
        quit = "<esc>",
    },
})

-- Lualine
require("lualine").setup({
    sections = {
        lualine_c = {
            { "filename", path = 1 },
            "lsp_progress",
        },
    },
})

-- indent-blankline
require("indent_blankline").setup({
    -- for example, context is off by default, use this to turn it on
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    filetype_exclude = { "help", "packer" },
    buftype_exclude = { "terminal", "nofile" },
    show_trailing_blankline_indent = false,
})

-- treesitter
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "python",
        "rust",
        "c",
        "cpp",
        "bash",
        "go",
        "html",
        "toml",
    },
    highlight = {
        enable = true,
    },
})

-- Tagbar
vim.cmd [[
nmap <F8> :TagbarOpenAutoClose<CR>
]]

-- FZF
vim.cmd [[
nnoremap <C-P> :Files<CR>
nnoremap <Tab> :GFiles<CR>
nnoremap <C-H> :GFiles?<CR>
nnoremap <C-K> :BLines<CR>
if executable('rg')
    nnoremap <C-G> :Rg<CR>
else
    echom "Ripgrep (rg) is missing. Please install Ripgrep"
endif
]]

-- auto-pairs-gentle
vim.g.AutoPairs = {
    ["("] = ")",
    ["["] = "]",
    ["{"] = "}",
    ["'"] = "'",
    ['"'] = '"',
    ["`"] = "`",
    -- ['<']='>',
}

-- vim-markdown
vim.g.vim_markdown_folding_disabled = true

-- vim-autoformat
vim.cmd [[
nnoremap <F3> :Autoformat<CR> :w<CR>
]]

-- markdown-preview
vim.cmd [[
nnoremap <M-m> :MarkdownPreviewToggle<CR>
]]

-- vim-python-pep8-indent
vim.g.python_pep8_indent_multiline_string = -1

-- vim-easy-align
vim.cmd [[
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
]]
-- 1}}}
