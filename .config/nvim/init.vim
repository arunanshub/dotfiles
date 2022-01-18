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
Plug 'neoclide/coc.nvim', {'branch': 'release'}             " code completion
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

" 4. coc.nvim extensions {{{1 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        4. coc.nvim extensions                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:coc_global_extensions = [
    \ 'coc-clangd',
    \ 'coc-highlight',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-lua',
    \ 'coc-markdownlint',
    \ 'coc-pyright',
    \ 'coc-rust-analyzer',
    \ 'coc-prettier',
    \ 'coc-sh',
    \ 'coc-ultisnips',
    \ 'coc-syntax',
    \ 'coc-word',
    \ 'coc-vimlsp',
\ ]
" 1}}} "

" 5. plugin configurations {{{1 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       5. plugin configurations                        "
"              Header of each section is the plugin's name              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

""""""""""""""""""""""
"  coc.nvim  "
""""""""""""""""""""""
" coc.nvim {{{2 "
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" 2}}} "
" 1}}} "
