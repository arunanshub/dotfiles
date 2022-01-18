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
set encoding=utf-8
set colorcolumn=80
set hidden
set list " display hints about extra whitespace
set nobackup nowritebackup
set nottimeout notimeout
set shortmess+=c
set smartcase number expandtab
set updatetime=300
set tabstop=4 shiftwidth=4
set background=dark
set noshowmode
set inccommand=nosplit

" speedup tweaks
set nocursorline
set lazyredraw
set scrolljump=5

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
"  Always present  "
""""""""""""""""""""
" Plug 'github/copilot.vim'
Plug 'SirVer/ultisnips'                                     " snippet engine
Plug 'Yggdroot/indentLine'                                  " display indent line for easy recognition
Plug 'antoinemadec/FixCursorHold.nvim'                      " Improve performance
Plug 'dstein64/vim-win'                                     " easy window navigation
Plug 'easymotion/vim-easymotion'                            " Vim motion on speed
Plug 'editorconfig/editorconfig-vim'                        " maintain consistent coding styles
Plug 'folke/todo-comments.nvim'                             " highlight instances of 'todo', 'fixme' etc.
Plug 'honza/vim-snippets'                                   " Snippet source
Plug 'mhinz/vim-signify'                                    " show diffs in style
Plug 'mhinz/vim-startify'                                   " fancy startpage for vim
Plug 'navarasu/onedark.nvim'                                " dark theme
Plug 'neovim/nvim-lspconfig'                                " FIXME: LSP: WORK IN PROGRESS
Plug 'williamboman/nvim-lsp-installer'                      " FIXME: LSP Installer: WORK IN PROGRESS
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}                   " FIXME: LSP: completion engine
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}        " FIXME: LSP: snippets
Plug 'nvim-lua/plenary.nvim'                                " lua functions
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " syntax highlighting
Plug 'scrooloose/nerdcommenter'                             " commenting functionality
Plug 'tpope/vim-abolish'                                    " text manipulation
Plug 'tpope/vim-repeat'                                     " repetition being good
Plug 'tpope/vim-sensible'                                   " sensible defaults
Plug 'tpope/vim-surround'                                   " surround text with stuff
Plug 'tpope/vim-unimpaired'                                 " useful mappings
Plug 'vim-airline/vim-airline'                              " status/tabline for vim
Plug 'vim-airline/vim-airline-themes'                       " themes for vim-airline
Plug 'vim-scripts/auto-pairs-gentle'                        " bracket autocompletion

"""""""""""""""""
"  Lazy Loaded  "
"""""""""""""""""
Plug 'junegunn/vim-easy-align', {'on': '<Plug>(EasyAlign)'}   " alignment of text
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}              " undo tree
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'} " python requirements file
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

"""""""""""""""""
"  Loaded last  "
"""""""""""""""""
Plug 'ryanoasis/vim-devicons'

call plug#end()
" 1}}} "

" 5. plugin configurations {{{1 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       5. plugin configurations                        "
"              Header of each section is the plugin's name              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""
"  lsp  "
"""""""""""""""""""

let g:coq_settings = { 'auto_start': 'shut-up' }

lua << EOF
local lsp_installer = require("nvim-lsp-installer")
local nvim_lsp = require("lspconfig")
local coq = require("coq")

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

lsp_installer.on_server_ready(function(server)
    local opts = {on_attach = on_attach}
    server:setup(opts)
end)
EOF

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
"  vim-airline  "
"""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_theme = 'onedark'
let g:airline_highlighting_cache = 1

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
