" -------------------------------------------------------------------------------------------------
" GENERAL SETTINGS
" -------------------------------------------------------------------------------------------------
set autowriteall                  " auto save files on certain events
set clipboard+=unnamedplus        " always use the clipboard instead of unnamed register
set completeopt=longest,menuone   " better insert mode auto completion
set cscopequickfix=s-,c-,a-       " enable cscope results in the quickfix window
set cscopetag                     " use cscope by default for tag jumps
set expandtab                     " tabs are spaces
set ignorecase                    " ignore case when searching lowercase
set inccommand=nosplit            " show the effect of a command as you type (eg. for substitute)
set list                          " show hidden characters
set mouse=a                       " enable mouse support
set nowrap                        " don't wrap
set pumblend=25                   " make popup-menus a little transparent
set shiftround                    " round to multiple of shift width when adjusting indentation
set shiftwidth=4                  " number of spaces for each step of auto indent
set smartcase                     " don't ignore case when inserting uppercase characters in search
set softtabstop=4                 " number of spaces per tab when editing
set tabstop=4                     " number of visual spaces per tab
set termguicolors                 " 24 bit color support
set undofile                      " persistent undo history
set updatetime=100                " milliseconds VIM will wait to trigger the CursorHold event
set visualbell                    " use visual bell instead of beeping
set wildmode=longest,full         " first complete to the longest match, then to the first full one
set wildoptions+=pum              " display command line completion matches in a popup menu

" add spelling dictionary
set spellfile=~/.local/shar/nvim/site/en.utf-8.add

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

    " auto save when a file is changed
    autocmd TextChanged, InsertLeave, FocusLost * silent! wall

    " check if the file has changed outside of Vim when the cursor has moved
    autocmd CursorHold * silent! checktime

    " enable spell checking by default for git commit files
    autocmd Filetype gitcommit setlocal spell

    " open quickfix and git commit window always at the bottom and with the full width of the screen
    autocmd FileType qf,gitcommit wincmd J

    " open quickfix/location list when it is populated
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost    l* lwindow
    autocmd VimEnter            * cwindow

    " automatically cleanup fugitive buffers
    autocmd BufReadPost fugitive://* set bufhidden=delete

    " automatically source vimrc on save
    autocmd! bufwritepost $MYVIMRC source $MYVIMRC
augroup END

" -------------------------------------------------------------------------------------------------
" ABBREVIATIONS
" -------------------------------------------------------------------------------------------------
" insert a C style to do comment
iabbrev TODO /* TODO dboucken: */<left><left><left>

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

" -------------------------------------------------------------------------------------------------
" LEADER KEY MAPPINGS
" -------------------------------------------------------------------------------------------------
" use space as leader
let mapleader=" "

" remap <c-w> to something easier
nnoremap <leader>w <c-w>

" quickly open vimrc
nnoremap <leader>ev :vertical split $MYVIMRC<cr>

" clear search highlighting
nnoremap <silent> <leader>l :nohlsearch<cr>

" delete trailing white space on a line
nnoremap <leader>dd :s/\s\+$//e<cr>

" close the quickfix window
nnoremap <silent> <leader>qc :cclose<cr>

" grep the word under the cursor recursively, don't return to be able to pass options and directories
nnoremap <leader>gw :grep! -rw <c-r><c-w> 

" grep the word under the cursor recursively in the directory of the current file
nnoremap <leader>gd :grep! -rw <c-r><c-w> %:p:h<cr>

" find cscope symbol under the cursor
nnoremap <leader>gs :cscope find s <c-r><c-w><cr><cr>

" find callers of the function under the cursor
nnoremap <leader>gc :cscope find c <c-r><c-w><cr><cr>

" paste last yanked text in normal and visual mode
nnoremap <leader>pp "0p
vnoremap <leader>pp "0p

" replace word with last yanked text
nnoremap <leader>pr viw"0p

" run the macro in register q
nnoremap <leader><leader> @q

" allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! w !sudo tee > /dev/null %

" -------------------------------------------------------------------------------------------------
" PLUGINS
" -------------------------------------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'  " a Vim plugin which shows a git diff in the gutter
Plug 'nanotech/jellybeans.vim' " color scheme
Plug 'neomake/neomake'         " asynchronous linter
Plug 'sheerun/vim-polyglot'    " language pack (eg. including better syntax highlighting)
Plug 'tpope/vim-commentary'    " comment stuff out
Plug 'tpope/vim-dispatch'      " async make
Plug 'tpope/vim-fugitive'      " a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-unimpaired'    " pairs of handy bracket mappings

call plug#end()

colorscheme jellybeans
