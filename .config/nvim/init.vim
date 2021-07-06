" File: init.vim
" Author: Arunanshu Biswas (@arunanshub)
" Description: A `init.vim` for the IDE beauty. Make sure you atleast have
" node installed. You may need to install other binaries depending on the coc
" extension.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      1. vim-plug installation                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:plug_dir = join([stdpath("config"), "autoload", "plug.vim"], "/")
if empty(glob(s:plug_dir)) || empty(glob(stdpath("config") . "/plugged"))
    silent exec "!curl -fLo" s:plug_dir
        \ "--create-dirs"
        \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    autocmd VimEnter * PlugInstall
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      2. vim-plug plugins                              "
"  Make sure you run `:PlugInstall` after launching `neovim` for the    "
"  first time.                                                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

Plug 'cespare/vim-toml' " TOML highlighting
Plug 'honza/vim-snippets' " easy snippets
Plug 'jiangmiao/auto-pairs' " bracket autocompletion
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " file finder
Plug 'junegunn/fzf.vim' " file finder stuff
Plug 'majutsushi/tagbar' " tagbar for easy code browsing (requires ctags)
Plug 'mbbill/undotree' " undo tree
Plug 'neoclide/coc.nvim', {'branch': 'release'} " code completion
Plug 'plasticboy/vim-markdown' " proper markdown highlighting
Plug 'scrooloose/nerdcommenter' " commenting functionality
Plug 'scrooloose/nerdtree' " tree
Plug 'tpope/vim-repeat' " repetition being good
Plug 'tpope/vim-sensible' " be sensible
Plug 'tpope/vim-surround' " surround text with stuff
Plug 'vim-airline/vim-airline' " the bottom bar
" Theme: not necessary ofcourse
Plug 'dracula/vim', { 'as': 'dracula' } " A nice looking theme

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      3. coc-nvim extensions                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:coc_global_extensions = [
    \ 'coc-clangd',
    \ 'coc-json',
    \ 'coc-lua',
    \ 'coc-markdownlint',
    \ 'coc-pyright',
    \ 'coc-rust-analyzer',
    \ 'coc-snippets',
    \ 'coc-vimlsp',
\ ]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      4. Misc. configurations                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme dracula
" for indenting
vmap <Tab> >gv
vmap <S-Tab> <gv

" neovim specific configuration
let g:pyindent_open_paren = 'shiftwidth()' " Fix python indentation
set nocompatible
set notimeout nottimeout
set cursorline
set smartindent smartcase number expandtab
set tabstop=4 shiftwidth=4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      4.1 plugin configurations                        "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>> tagbar
nmap <F8> :TagbarToggle<CR>
" <<< end tagbar

" >>> undotree
nnoremap <F5> :UndotreeToggle<CR>
" <<< end undotree

" >>> auto pairs
let g:AutoPairsMultilineClose = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'
" <<< end auto pairs

" >>> vim-markdown
let g:vim_markdown_folding_disabled = 1
" <<< end vim-markdown

" >>> fzf and ag
nnoremap <C-P> :Files<CR>
nnoremap <C-I> :GFiles<CR>
if executable("ag")
    nnoremap <C-G> :Ag<CR>
endif
" <<< end fzf and ag

" >>> NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-i> :NERDTreeFind<CR>
" <<< end NERDTree

" >>> NERD commenter
let g:NERDAltDelims_java = 1
let g:NERDCommentEmptyLines = 1
let g:NERDCompactSexyComs = 1
let g:NERDCreateDefaultMappings = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
let g:NERDToggleCheckAllLines = 1
let g:NERDTrimTrailingWhitespace = 1
" <<< End NERD commenter

" >>> CoC-Nvim
set hidden
set nobackup
set nowritebackup
set shortmess+=c
set updatetime=200

if has("nvim-0.5.0") || has("patch-8.1.1564")
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
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)

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

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
omap ac <Plug>(coc-classobj-a)
omap af <Plug>(coc-funcobj-a)
omap ic <Plug>(coc-classobj-i)
omap if <Plug>(coc-funcobj-i)
xmap ac <Plug>(coc-classobj-a)
xmap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
xmap if <Plug>(coc-funcobj-i)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
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
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

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
" <<< End CoC-Nvim
