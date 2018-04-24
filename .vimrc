" -------------------------------------------------------------------------------------------------
" GENERAL SETTINGS
" -------------------------------------------------------------------------------------------------
filetype plugin indent on         " file type detection, load file type plugins and indent files
syntax on                         " enable syntax highlighting
set synmaxcol=250                 " only syntax highlight the first 250 columns
set wildmenu                      " visual auto complete for command menu
set report=0                      " always report changed lines
set lazyredraw                    " don't redraw the screen during macros to improve performance
set ttyfast                       " always assume a fast terminal
set autoread                      " reload file when changed outside vim
set splitbelow                    " open new horizontal split below the current one
set splitright                    " open new vertical split right of the current one
set visualbell                    " use visual bell instead of beeping
set backspace=indent,eol,start    " allow backspacing over auto indent, line breaks, insert action
set hidden                        " buffer becomes hidden when it is abandoned
set cmdheight=2                   " increase the height of the command bar
set nowrap                        " don't wrap
set laststatus=2                  " always show the status line
set completeopt=longest,menuone   " better insert mode auto completion
set mouse=a                       " enable mouse support
set autowriteall                  " auto save files
set scrolloff=1                   " always keep a line from the top and the bottom to the cursor
set number                        " enable line numbers
set showmode                      " show mode in command line
set ruler                         " show line number info in status line
set formatoptions+=j              " delete comment character when joining lines
set termguicolors                 " enable true colors (assuming the terminal emulator supports it)
set tabstop=4                     " number of visual spaces per tab
set softtabstop=4                 " number of spaces per tab when editing
set expandtab                     " tabs are spaces
set shiftround                    " round to multiple of shift width when adjusting indentation
set shiftwidth=4                  " number of spaces for each step of auto indent
set autoindent                    " auto indent on a new line
set incsearch                     " search as characters are entered
set hlsearch                      " highlight matches
set ignorecase                    " ignore case when searching lowercase
set smartcase                     " don't ignore case when inserting uppercase characters
set nobackup                      " disable backups
set noswapfile                    " disable swap files
set cscopequickfix=s-,c-          " enable cscope results in the quickfix window
set cscopetag                     " use cscope by default for tag jumps
set notimeout                     " never timeout on mappings
set ttimeout                      " timeout on key codes
set ttimeoutlen=200               " timeout length on key codes
set wildignore+=*cscope*          " ignore cscope files when expanding wild cards
set wildignore+=tags              " ignore tag files when expanding wild cards
set spelllang=en_us               " use English as spelling language
set spellfile=~/.vim/en.utf-8.add " add spelling dictionary
set list                          " show non-printable characters
set listchars=tab:>\              " tab
set listchars+=trail:-            " trailing white space
set listchars+=extends:>          " line continues on the right
set listchars+=precedes:<         " line continues on the left
set listchars+=nbsp:+             " unbreakable space
colorscheme desert                " set color scheme
runtime! macros/matchit.vim       " extend % to HTML tags
runtime! ftplugin/man.vim         " read man pages in vim via :Man <command>
let g:ft_man_open_mode = 'vert'   " open man pages in a vertical split

" -------------------------------------------------------------------------------------------------
" FUNCTIONS
" -------------------------------------------------------------------------------------------------
" load cscope database
function! LoadCscope() abort
    " search for a cscope database in the current directory and all upward parent directories
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
        let path = strpart(db, 0, match(db, "/cscope.out$"))
        set nocscopeverbose
        exe "cs add " . db . " " . path
        set cscopeverbose
    endif
endfunction

" -------------------------------------------------------------------------------------------------
" AUTO COMMANDS
" -------------------------------------------------------------------------------------------------
augroup custom_autocommands
    " clear all auto commands in this group
    autocmd!

    " add extra syntax highlighting for c functions and macros
    autocmd Syntax c,cpp syntax match cFunction /\<\w\+\s*(/me=e-1,he=e-1
    autocmd Syntax c,cpp syntax match cMacro /\<[A-Z_]\+\s*(/me=e-1,he=e-1
    autocmd Syntax c,cpp highlight def link cFunction Function
    autocmd Syntax c,cpp highlight def link cMacro Macro

    " auto load cscope database
    autocmd BufEnter /* call LoadCscope()

    " auto save when a file is changed
    autocmd TextChanged, InsertLeave, FocusLost * silent! wall

    " check if the file has changed outside of vim when the cursor has moved
    autocmd CursorHold * silent! checktime

    " enable spell checking for markdown and git commit files
    autocmd Filetype markdown,gitcommit setlocal spell

    " set text width and tab size for markdown files
    autocmd Filetype markdown setlocal textwidth=100
    autocmd Filetype markdown setlocal tabstop=2
    autocmd Filetype markdown setlocal softtabstop=2
    autocmd Filetype markdown setlocal shiftwidth=2

    " don't show invisible characters in man pages
    autocmd Filetype man setlocal nolist

    " open quickfix and git commit window always at the bottom and with the full width of the screen
    autocmd FileType qf,gitcommit wincmd J

    " open quickfix/location list when it is populated
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost    l* lwindow
    autocmd VimEnter            * cwindow

    " automatically cleanup fugitive buffers
    autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

" -------------------------------------------------------------------------------------------------
" ABBREVIATIONS
" -------------------------------------------------------------------------------------------------
" open help in a vertical split
cabbrev H vert h

" insert to do comment
iabbrev TODO /* TODO dboucken: */<left><left><left>

" -------------------------------------------------------------------------------------------------
" CUSTOM KEY MAPPINGS
" -------------------------------------------------------------------------------------------------
" remap escape in insert mode
inoremap jj <Esc>

" remap : in normal mode
nnoremap ; :

" always use very magic regular expressions when searching
nnoremap / /\v

" auto expand curly brackets in insert mode
inoremap {<cr> {<cr>}<Esc>O

" -------------------------------------------------------------------------------------------------
" LEADER KEY MAPPINGS
" -------------------------------------------------------------------------------------------------
" use space as leader
let mapleader=" "

" remap <c-w> to something easier
nnoremap <leader>w <c-w>

" clear search highlighting
nnoremap <silent> <leader>l :nohlsearch<cr>

" edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" edit scratchpad
nnoremap <leader>es :vsplit ~/scratchpad.md<cr>

" delete trailing white space on a line
nnoremap <leader>dd :s/\s\+$//e<cr>

" make
nnoremap <leader>m :make<cr>

" toggle quickfix window
nnoremap <silent> <leader>qo :copen<cr>
nnoremap <silent> <leader>qc :cclose<cr>

" search files in the working directory
nnoremap <leader>oo :e **/

" regex tag search
nnoremap <leader>tt :tj /

" grep, don't return to be able to pass options and files
nnoremap <leader>gr :grep 

" grep the word under the cursor, don't return to be able to pass options and files
nnoremap <leader>gw :grep -w <c-r><c-w> 

" find cscope symbol under the cursor
nnoremap <leader>gs :cs find s <c-r><c-w><cr><cr>

" find callers of function under the cursor
nnoremap <leader>gc :cs find c <c-r><c-w><cr><cr>

" easier change and replace word
nnoremap <leader>cw *Ncgn

" paste last yanked text
nnoremap <leader>pp "0p
vnoremap <leader>pp "0p

" replace word with last yanked text
nnoremap <leader>pr viw"0p

" run macro in register q
nnoremap <leader><leader> @q

" -------------------------------------------------------------------------------------------------
" PLUGINS
" -------------------------------------------------------------------------------------------------
" install vim-plug if it is not installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd vimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'tpope/vim-commentary' " comment stuff out
Plug 'tpope/vim-fugitive'   " a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-surround'   " plugin for deleting, changing and adding surroundings
Plug 'tpope/vim-unimpaired' " pairs of handy bracket mappings

call plug#end()
