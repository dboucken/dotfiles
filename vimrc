" -------------------------------------------------------------------------------------------------
" GENERAL SETTINGS
" -------------------------------------------------------------------------------------------------
filetype plugin indent on         " enable filetype detection
set autoindent                    " auto indent when inserting a new line
set autoread                      " reload a file when it is changed outside vim
set autowriteall                  " auto save files on certain events
set backspace=indent,eol,start    " allow backspacing over auto indent, line breaks, insert action
set clipboard=exclude:.*          " don't try to connect to X server
set complete-=i                   " don't scan include files during insert mode auto completion
set completeopt=longest,menuone   " better insert mode auto completion
set cscopequickfix=s-,c-,a-       " enable cscope results in the quickfix window
set cscopetag                     " use cscope by default for tag jumps
set expandtab                     " tabs are spaces
set formatoptions+=j              " delete comment character when joining lines
set hlsearch                      " highlight matches
set ignorecase                    " ignore case when searching lowercase
set incsearch                     " search as characters are entered
set list                          " show trailing whitespace
set listchars=tab:>\ ,trail:-     " show tabs and trailing white space when list is enabled
set mouse=a                       " enable mouse support
set noswapfile                    " disable swap files
set notimeout                     " never timeout on mappings
set nowrap                        " don't wrap
set ruler                         " show line and column number in command line
set shiftround                    " round to multiple of shift width when adjusting indentation
set shiftwidth=4                  " number of spaces for each step of auto indent
set smartcase                     " don't ignore case when inserting uppercase characters in search
set softtabstop=4                 " number of spaces per tab when editing
set spellfile=~/.vim/en.utf-8.add " add spelling dictionary
set tabstop=4                     " number of visual spaces per tab
set ttimeout                      " timeout on key codes
set ttimeoutlen=200               " timeout length on key codes
set ttymouse=xterm2               " enable mouse dragging
set undodir=~/.vim/undo//         " undo history directory
set undofile                      " persistent undo history
set updatetime=100                " milliseconds VIM will wait to trigger the CursorHold event
set visualbell                    " use visual bell instead of beeping
set wildmenu                      " visual auto complete for command menu
set wildmode=longest,full         " first complete to the longest match, then to the first full one
syntax on                         " enable syntax highlighting

" open man pages in vim with :Man
runtime ftplugin/man.vim

" auto load cscope database
if filereadable("cscope.out")
    silent! cscope add cscope.out
endif

" -------------------------------------------------------------------------------------------------
" AUTO COMMANDS
" -------------------------------------------------------------------------------------------------
augroup custom_autocommands
    " clear all auto commands in this group
    autocmd!

    " check if the file has changed outside of Vim when the cursor has moved
    autocmd CursorHold * silent! checktime

    " enable spell checking by default for git commit files
    autocmd Filetype gitcommit setlocal spell

    " enable spell checking and show hidden chars for markdown files by default
    autocmd Filetype markdown setlocal spell
    autocmd Filetype markdown setlocal list
    autocmd Filetype markdown setlocal textwidth=100

    " don't show hidden characters in man pages
    autocmd Filetype man setlocal nolist

    " open quickfix and git commit window always at the bottom and with the full width of the screen
    autocmd FileType qf,gitcommit wincmd J

    " open quickfix/location list when it is populated
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost    l* lwindow
    autocmd VimEnter            * cwindow
augroup END

" -------------------------------------------------------------------------------------------------
" ABBREVIATIONS
" -------------------------------------------------------------------------------------------------
" insert a C style to do comment
iabbrev TODO /* TODO dboucken: */<left><left><left>

" insert a C style DO_NOT_COMMIT comment
iabbrev DO /* DO_NOT_COMMIT: */<left><left><left>

" -------------------------------------------------------------------------------------------------
" CUSTOM KEY MAPPINGS
" -------------------------------------------------------------------------------------------------
" remap escape in insert mode
inoremap jj <Esc>

" remap : in normal mode
nnoremap ; :

" auto expand curly brackets in insert mode
inoremap {<cr> {<cr>}<Esc>O

" keep the found words in the middle of screen when jumping to the next/previous
nnoremap n nzzzv
nnoremap N Nzzzv

" -------------------------------------------------------------------------------------------------
" LEADER KEY MAPPINGS
" -------------------------------------------------------------------------------------------------
" use space as leader
let mapleader=" "

" remap <c-w> to something easier
nnoremap <leader>w <c-w>

" quickly open vimrc
nnoremap <leader>ev :vertical split $MYVIMRC<cr>

" delete trailing white space on a line
nnoremap <leader>dd :s/\s\+$//e<cr>

" open/close the quickfix list window
nnoremap <silent> <leader>qo :copen<cr>
nnoremap <silent> <leader>qc :cclose<cr>

" find cscope symbol under the cursor
nnoremap <leader>gs :cscope find s <c-r><c-w><cr><cr>

" find callers of the function under the cursor
nnoremap <leader>gc :cscope find c <c-r><c-w><cr><cr>

" grep the word under the cursor recursively, don't return to be able to pass options and dirs
nnoremap <leader>gw :grep! -rw <c-r><c-w> 

" grep the word under the cursor recursively in the directory of the current file
nnoremap <leader>gd :grep! -rw <c-r><c-w> %:p:h<cr>

" run the macro in register q
nnoremap <leader><leader> @q

" allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! w !sudo tee > /dev/null %

" open files recursively in the working directory
nnoremap <leader>ee :e **/*

" clear search highlight
nnoremap <leader>hl :nohlsearch<cr>

" replace the word under the cursor with the last yanked (not deleted) text
nnoremap <leader>pp ciw<C-r>0<ESC>

" preview a tag and close the preview window
nnoremap <leader>pt :ptag <c-r><c-w><cr>
nnoremap <leader>pc :pclose<cr>

" -------------------------------------------------------------------------------------------------
" PLUGINS
" -------------------------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

Plug 'NLKNguyen/papercolor-theme'
Plug 'airblade/vim-gitgutter'
Plug 'prabirshrestha/vim-lsp'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'

call plug#end()

" -------------------------------------------------------------------------------------------------
" PLUGIN SETTINGS
" -------------------------------------------------------------------------------------------------
" color scheme
set background=light
colorscheme PaperColor

" register LSP servers
if executable('pyls')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif

if executable('ccls')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'ccls',
        \ 'cmd': {server_info->['ccls']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
        \ 'initialization_options': {'cache': {'directory': expand('~/.cache/ccls')}, 'index': {'threads': 1}},
        \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
        \ })
endif

if executable('gopls')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls']},
        \ 'allowlist': ['go'],
        \ })
    autocmd BufWritePre *.go LspDocumentFormatSync
endif

if executable('rust-analyzer')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'Rust Language Server',
        \ 'cmd': {server_info->['rust-analyzer']},
        \ 'allowlist': ['rust'],
        \ })
endif

" function to enable LSP in a buffer
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
endfunction

" enable LSP in buffers for languages with registered servers
augroup lsp_install
    autocmd!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
