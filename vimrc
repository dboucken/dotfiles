" -------------------------------------------------------------------------------------------------
" GENERAL SETTINGS
" -------------------------------------------------------------------------------------------------
filetype plugin indent on         " enable filetype detection
set autoindent                    " auto indent when inserting a new line
set autoread                      " reload a file when it is changed outside vim
set autowriteall                  " auto save files on certain events
set background=dark               " always assume a dark terminal background
set backspace=indent,eol,start    " allow backspacing over auto indent, line breaks, insert action
set complete-=i                   " don't scan include files during insert mode auto completion
set completeopt=longest,menuone   " better insert mode auto completion
set cscopequickfix=s-,c-,a-       " enable cscope results in the quickfix window
set cscopetag                     " use cscope by default for tag jumps
set expandtab                     " tabs are spaces
set formatoptions+=j              " delete comment character when joining lines
set hlsearch                      " highlight matches
set ignorecase                    " ignore case when searching lowercase
set incsearch                     " search as characters are entered
set list                          " show hidden characters
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
set visualbell                    " use visual bell instead of beeping
set wildmenu                      " visual auto complete for command menu
set wildmode=longest,full         " first complete to the longest match, then to the first full one
syntax on                         " enable syntax highlighting

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

    " enable spell checking by default for git commit files
    autocmd Filetype gitcommit setlocal spell

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

" open help in a vertical split
cabbrev h vertical help

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

" grep the word under the cursor recursively, don't return to be able to pass options and dirs
nnoremap <leader>gw :grep! -rw <c-r><c-w> 

" grep the word under the cursor recursively in the directory of the current file
nnoremap <leader>gd :grep! -rw <c-r><c-w> %:p:h<cr>

" find cscope symbol under the cursor
nnoremap <leader>gs :cscope find s <c-r><c-w><cr><cr>

" find callers of the function under the cursor
nnoremap <leader>gc :cscope find c <c-r><c-w><cr><cr>

" run the macro in register q
nnoremap <leader><leader> @q

" allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! w !sudo tee > /dev/null %

" replace word with last yanked text
nnoremap <leader>p viw"0p

" git blame 25 lines before and after the current line
nnoremap <leader>gb :!git blame -L<c-r>=line('.')<cr>,-25 -L<c-r>=line('.')<cr>,+25 %<cr>
