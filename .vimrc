" -------------------------------------------------------------------------------------------------
" GENERAL SETTINGS
" -------------------------------------------------------------------------------------------------
filetype plugin indent on         " attempt to determine file type
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
colorscheme evening               " set color scheme
runtime! macros/matchit.vim       " extend % to HTML tags
runtime! ftplugin/man.vim         " read man pages in vim via :Man <command>
let g:ft_man_open_mode = 'vert'   " open man pages in a vertical split
if executable("rg")               " use ripgrep when it is available
    set grepprg=rg\ --vimgrep\ -S " use vimgrep format and smart case
    set grepformat^=%f:%l:%c:%m   " file name:line number:column number:message
endif

" -------------------------------------------------------------------------------------------------
" FUNCTIONS
" -------------------------------------------------------------------------------------------------
" add extra syntax highlighting for c functions
function! EnhanceCSyntax() abort
    syntax match cFunction /\<\w\+\s*(/me=e-1,he=e-1
    syntax match cMacro /\<[A-Z_]\+\s*(/me=e-1,he=e-1
    highlight def link cFunction Function
    highlight def link cMacro Macro
endfunction

" load cscope database
function! LoadCscope() abort
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

    " enhance c syntax highlighting
    autocmd Syntax c,cpp call EnhanceCSyntax()

    " auto load cscope database
    autocmd BufEnter /* call LoadCscope()

    " auto save when a file is changed
    autocmd TextChanged, InsertLeave, FocusLost * silent! wall

    " check if the file has changed outside of vim when the cursor has moved
    autocmd CursorHold * silent! checktime

    " enable spell checking for markdown and gitcommit files
    autocmd Filetype markdown,gitcommit setlocal spell

    " set text width for markdown files
    autocmd Filetype markdown setlocal textwidth=100

    " don't show invisible characters in man pages
    autocmd Filetype man setlocal nolist

    " open quickfix and gitcommit window always at the bottom and with the full width of the screen
    autocmd FileType qf,gitcommit wincmd J

    " open quickfix/location list when it is populated
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost    l* lwindow
    autocmd VimEnter            * cwindow
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

" remap <C-w>
nnoremap <leader>w <C-w>

" remap tag jump <C-]>
nnoremap <leader>] <C-]>

" clear search highlighting
nnoremap <leader>l :nohlsearch<cr>

" quickly open vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" delete trailing white space on a line
nnoremap <leader>dd :s/\s\+$//e<cr>

" make
nnoremap <leader>m :make<cr>

" toggle quickfix window
nnoremap <silent> <leader>qo :copen<cr>
nnoremap <silent> <leader>qc :cclose<cr>

" search files in the working directory
nnoremap <leader>oo :e **/

" regex tags search
nnoremap <leader>tt :tj /

" recursive grep, don't return to be able to pass options and directory
nnoremap <leader>gr :grep 

" grep the word under the cursor, don't return to be able to pass options and directory
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
" LOCAL VIMRC
" -------------------------------------------------------------------------------------------------
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" -------------------------------------------------------------------------------------------------
" PLUGINS
" -------------------------------------------------------------------------------------------------
" install vim-plug if it is not installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd vimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins should be added after this line
call plug#begin()

Plug 'tpope/vim-commentary' " comment stuff out
Plug 'tpope/vim-fugitive'   " a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-surround'   " plugin for deleting, changing and adding surroundings
Plug 'tpope/vim-unimpaired' " pairs of handy bracket mappings

" plugins should be added before this line
call plug#end()
