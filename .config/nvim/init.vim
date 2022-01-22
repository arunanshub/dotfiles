" vim:set et sw=4 ts=8 tw=78 fdm=marker:
" File: init.vim
" Author: Arunanshu Biswas (@arunanshub)
" Description: A `init.vim` for the IDE beauty. Make sure you atleast have
" node installed. You may need to install other binaries depending on the coc
" extension.

" 1. vim-plug installation {{{1 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       1. vim-plug installation                        "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:plug_dir = join([stdpath("config"), "autoload", "plug.vim"], "/")
if empty(glob(s:plug_dir)) || empty(glob(stdpath("data") . "/plugged"))
    echo "Now installing vim-plug..."
    silent exec "!curl -fLo" s:plug_dir
        \ "--create-dirs"
        \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

    echo "Installing and Upgrading all Plugins"

    augroup plugin_installer
        autocmd!
        autocmd VimEnter * PlugInstall
    augroup END

    echo "Done!"
endif
" 1}}} "

" 2. Neovim configurations {{{1 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       2. Neovim configurations                        "
"  Anything related to neovim in general and not specific to plugins.   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" highlight on search
set nohlsearch
" make line numbers default
set number
" enable break indent
set breakindent
" smart searching
set smartcase
" decrease update time
set updatetime=250
" NOTE: This option is required for properly showing errors
set signcolumn=yes
" set encoding
set encoding=utf-8
" display hints about extra whitespace
set list
" show effect of command incrementally
set inccommand=nosplit
" set completeopt for better completion experience
set completeopt=menu,menuone,noselect
" set incremental search
set incsearch
" do not show the current mode of Neovim
set noshowmode
" set background FIXME
set background=dark
" show hint about column limit
set colorcolumn=80
" expand space with spaces
set expandtab
" disble backup files
set nobackup nowritebackup
" disable timeout for leader key
set nottimeout notimeout
" set shortmess+=c

if has("termguicolors")
    set termguicolors " 24 bit colors for the love of life
endif

" disable netrw plugin
let g:loaded_netrw = 0
let g:loaded_netrwPlugin = 0

" for indenting
vmap <Tab> >gv
vmap <S-Tab> <gv

vnoremap <leader>y "+y<CR>
nnoremap <leader>p "+p<CR>

cnoreabbrev W w
" 1}}} "

" 3. vim-plug plugins {{{1 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          3. vim-plug plugins                          "
"   Make sure you run `:PlugInstall` after launching `neovim` for the   "
"   first time.                                                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()

""""""""""""""""""""
"  LSP specific    "
""""""""""""""""""""
Plug 'neovim/nvim-lspconfig'           " FIXME: LSP: WORK IN PROGRESS
Plug 'williamboman/nvim-lsp-installer' " FIXME: LSP Installer: WORK IN PROGRESS
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" snippets
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'

" customizations over LSP
Plug 'tami5/lspsaga.nvim'
Plug 'onsails/lspkind-nvim'

" statusline support
Plug 'nvim-lua/lsp-status.nvim'

" statusline
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

""""""""""""""""""""
"  Always present  "
""""""""""""""""""""
" Plug 'github/copilot.vim'
Plug 'navarasu/onedark.nvim'                                " dark theme
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " syntax highlighting
Plug 'folke/todo-comments.nvim'                             " highlight instances of 'todo', 'fixme' etc.
Plug 'tpope/vim-unimpaired'                                 " useful mappings
Plug 'Yggdroot/indentLine'                                  " display indent line for easy recognition
Plug 'vim-scripts/auto-pairs-gentle'                        " bracket autocompletion
Plug 'antoinemadec/FixCursorHold.nvim'                      " Improve performance
Plug 'editorconfig/editorconfig-vim'                        " maintain consistent coding styles
Plug 'scrooloose/nerdcommenter'                             " commenting functionality
Plug 'mhinz/vim-signify'                                    " show diffs in style
Plug 'tpope/vim-surround'                                   " surround text with stuff
Plug 'easymotion/vim-easymotion'                            " Vim motion on speed
" Plug 'nvim-lua/plenary.nvim'                                " lua functions
" Plug 'dstein64/vim-win'                                     " easy window navigation
" Plug 'mhinz/vim-startify'                                   " fancy startpage for vim
" Plug 'tpope/vim-abolish'                                    " text manipulation
" Plug 'tpope/vim-repeat'                                     " repetition being good
" Plug 'tpope/vim-sensible'                                   " sensible defaults

"""""""""""""""""
"  Lazy Loaded  "
"""""""""""""""""
Plug 'junegunn/vim-easy-align', {'on': '<Plug>(EasyAlign)'}   " alignment of text
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}              " undo tree
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'} " python requirements file
Plug 'glench/vim-jinja2-syntax', {'for': ['html', 'jinja2']}
Plug 'tpope/vim-fugitive', {'on': ['G', 'Git']}               " Git within vim
Plug 'vim-autoformat/vim-autoformat', {'on': 'Autoformat'}    " Autoformat

" file finder and helper
let g:fzf_cmds = ['Files', 'GFiles', 'Windows', 'Rg', 'BLines']
Plug 'junegunn/fzf', {'do': {-> fzf#install()}, 'on': g:fzf_cmds}
Plug 'junegunn/fzf.vim', {'on': g:fzf_cmds}
unlet g:fzf_cmds

if executable("ctags")
    " tagbar for easy code browsing (requires ctags)
    Plug 'majutsushi/tagbar', {'on': 'TagbarOpenAutoClose'}
else
    echom "ctags is missing. Please install ctags."
endif

" Live Markdown preview
Plug 'iamcco/markdown-preview.nvim', {
    \ 'do': {-> mkdp#util#install()},
    \ 'for': ['markdown', 'vim-plug'],
    \ 'on': ['MarkdownPreviewToggle'],
\ }

" directory tree
Plug 'scrooloose/nerdtree', {
    \ 'on': ['NERDTreeFind', 'NERDTreeFocus', 'NERDTreeToggle'],
\ }

call plug#end()
" 1}}} "

" 5. plugin configurations {{{1 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       5. plugin configurations                        "
"              Header of each section is the plugin's name              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" LSP/LSP Installer {{{2 "
"""""""""""""""""""
"  LSP/Installer  "
"""""""""""""""""""
lua << EOF
require('lspsaga').init_lsp_saga()

local lsp_status = require('lsp-status')
lsp_status.register_progress()

local lsp_installer = require("nvim-lsp-installer")
local nvim_lsp = require("lspconfig")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  lsp_status.on_attach(client)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = {noremap=true, silent=true}

  buf_set_keymap('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
  buf_set_keymap('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)
  buf_set_keymap('n', '<leader>rn', "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
  buf_set_keymap('n', '<leader>ca', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts)
  buf_set_keymap('v', '<leader>a', "<cmd>lua require('lspsaga.codeaction').range_code_action()<CR>", opts)
end

capabilities = require('cmp_nvim_lsp')
  .update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    capabilities = capabilities,
  }
  if server.name == "pylsp" then
    opts.settings = {
      pylsp = {
        plugins = {
          jedi_completion = { include_params = true },
        }
      }
    }
  end
  server:setup(opts)
end)
EOF
" 2}}} "

" Statusline
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

" LSP Completer {{{2 "
"""""""""""""""""""
"  lsp  "
"""""""""""""""""""
lua << EOF
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- Setup nvim-cmp.
local cmp = require('cmp')
local lspkind = require('lspkind')

local cmp_kinds = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "ﰠ",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "塞",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "פּ",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      preset = 'codicons',
      symbol_map = cmp_kinds,
      menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
      }),
    }),
  },

  snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
  },

  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<CR>'] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
    ['<C-y>'] = cmp.config.disable,

    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
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

  -- sources for completion
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = "nvim_lua" },
    -- { name = 'vsnip' },
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
EOF
" 2}}} "

"""""""""""""""""""
"  todo-comments  "
"""""""""""""""""""
lua << EOF
require'todo-comments'.setup()
EOF

""""""""""""""""""""""
"  treesitter  "
""""""""""""""""""""""
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {"python", "rust", "c", "cpp", "bash", "go", "html"},
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF

"""""""""""""""""
"  lualine      "
"""""""""""""""""
lua << EOF
require('lualine').setup()
EOF

""""""""""""""""""""
"  vim-autoformat  "
""""""""""""""""""""
noremap <F3> :Autoformat<CR> :w<CR>

""""""""""""""""""""""
"  markdown-preview  "
""""""""""""""""""""""
nnoremap <M-m> :MarkdownPreviewToggle<CR>

"""""""""""""""
"  ultisnips  "
"""""""""""""""
" map an unused key to expand trigger to prevent it from interfering with Coc.
let g:UltiSnipsExpandTrigger="<F13>"

""""""""""""""""""""""
"  vim-win  "
""""""""""""""""""""""
let g:win_ext_command_map = {"\<cr>": 'Win#exit'}

""""""""""""""""""""""
"  indentLine  "
""""""""""""""""""""""
let g:indentLine_char = '▏'
let g:indentLine_fileTypeExclude = ['startify', 'markdown']

""""""""""""""""""""""
"  auto-pairs-gentle "
""""""""""""""""""""""
" let g:AutoPairsMapSpace = 0
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`', '<':'>'}

""""""""""""""""""""""
"  vim-easy-align  "
""""""""""""""""""""""
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

""""""""""""""""""""""
"  signify  "
""""""""""""""""""""""
nnoremap <F4> :SignifyHunkDiff<CR>

""""""""""""""""""""""
"  todo-comments  "
""""""""""""""""""""""
lua << EOF
-- require("todo-comments").setup()
EOF

""""""""""""""""""""""
"  onedark  "
""""""""""""""""""""""
let g:onedark_config = {"style": "darker"}
colorscheme onedark

""""""""""""""""""""""
"  tagbar  "
""""""""""""""""""""""
nmap <F8> :TagbarOpenAutoClose<CR>

""""""""""""""""""""""
"  undotree  "
""""""""""""""""""""""
nnoremap <F5> :UndotreeToggle<CR>

""""""""""""""""""""""
"  fzf,fzf.vim,ag  "
""""""""""""""""""""""
nnoremap <C-P> :Files<CR>
nnoremap <C-I> :GFiles<CR>
nnoremap <C-K> :BLines<CR>
if executable('rg')
    nnoremap <C-G> :Rg<CR>
else
    echom "Ripgrep (rg) is missing. Please install Ripgrep"
endif

""""""""""""""""""""""
"  nerdtree  "
""""""""""""""""""""""
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <F6>     :NERDTreeToggle<CR>
nnoremap <F7>     :NERDTreeFind<CR>

""""""""""""""""""""""
"  nerdcommenter  "
""""""""""""""""""""""
let g:NERDCommentEmptyLines      = 1
let g:NERDCreateDefaultMappings  = 1
let g:NERDDefaultAlign           = 'left'
let g:NERDSpaceDelims            = 1
let g:NERDToggleCheckAllLines    = 1
let g:NERDTrimTrailingWhitespace = 1
" 1}}} "
