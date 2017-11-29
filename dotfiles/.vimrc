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

Plug 'tpope/vim-fugitive'                                        " git wrapper
Plug 'tpope/vim-surround'                                        " all about surroundings
Plug 'tpope/vim-commentary'                                      " commenting
Plug 'tpope/vim-unimpaired'                                      " some useful key mappings
Plug 'tpope/vim-dispatch'                                        " async make
Plug 'airblade/vim-gitgutter'                                    " show git diff in gutter
Plug 'wincent/ferret'                                            " async grep and replace
Plug 'godlygeek/tabular'                                         " align text
Plug 'vim-airline/vim-airline'                                   " enhanced status bar
Plug 'vim-airline/vim-airline-themes'                            " status bar color themes
Plug 'edkolev/tmuxline.vim'                                      " apply themes to tmux status bar
Plug 'nanotech/jellybeans.vim'                                   " color scheme
Plug 'morhetz/gruvbox'                                           " color scheme
Plug 'w0rp/ale',                {'for': ['javascript','python']} " async linting
Plug 'sedan07/vim-mib',         {'for': 'mib'}                   " mib syntax highlighting
Plug 'nathanalderson/yang.vim', {'for': 'yang'}                  " yang syntax highlighting
Plug 'pangloss/vim-javascript', {'for': 'javascript'}            " better javascript support
Plug 'junegunn/fzf',            {'dir': '~/.fzf', 'do': './install --all'} " fast fuzzy search
Plug 'junegunn/fzf.vim'                                          " useful fzf commands

" all plugins should be added before this line
call plug#end()

" -------------------------------------------------------------------------------------------------
" GENERAL SETTINGS
" -------------------------------------------------------------------------------------------------
filetype plugin indent on       " attempt to determine file type
syntax on                       " enable syntax highlighting
set synmaxcol=250               " only syntax highlight the first 250 columns
set cursorline                  " highlight current line
set colorcolumn=101             " set vertical line at 101 characters
set wildmenu                    " visual autocomplete for command menu
set report=0                    " always report changed lines
set lazyredraw                  " only redraw when necessary
set ttyfast                     " always assume a fast terminal
set autoread                    " reload file when changed outside vim
set showmatch                   " show matching brackets
set display+=lastline           " show as much as possible of the last line
set splitbelow                  " open new horizontal split below the current one
set splitright                  " open new vertical split right of the current one
set history=1000                " increase history
set undolevels=1000             " increase undo levels
set visualbell                  " use visual bell instead of beeping
set backspace=indent,eol,start  " allow backspacing over autoindent, line breaks and insert action
set hidden                      " buffer becomes hidden when it is abandoned
set cmdheight=2                 " increase the height of the command bar
set nowrap                      " dont't wrap
set laststatus=2                " always show the status line
set completeopt=longest,menuone " better autocompletion
set mouse=a                     " enable mouse support
set autowriteall                " autosave files
set noshowmode                  " don't show mode as we use a status line plugin
set scrolloff=1                 " always keep a couple of lines from the top and the bottom
set number                      " enable line numbers
set tags+=~/.vim/systags        " add system functions tag files
set complete-=i                 " don't search include files to improve autocompletion performance
set complete-=t                 " don't search tags to improve autocompletion performance
runtime! ftplugin/man.vim       " read man pages inside vim via :Man <cmd>

" tabs and indentation
set tabstop=4     " number of visual spaces per tab
set softtabstop=4 " number of spaces per tab when editing
set expandtab     " tabs are spaces
set shiftround    " round to multiple of shiftwidth when adjusting indentation
set shiftwidth=4  " number of spaces for each step of autoindent
set autoindent    " auto indent on a new line

" key timeouts, quickly time out on keycodes, but never time out on mappings
set notimeout
set ttimeout
set ttimeoutlen=200

" non printable characters
set list                                                  " show non-printable characters
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+ " customize shown characters

" search
set incsearch  " search as characters are entered
set hlsearch   " highlight matches
set ignorecase " ignore case when searching lowercase
set smartcase  " don't ignore case when inserting uppercase characters

" backups
set nobackup   " disable backups
set noswapfile " disable swapfiles

" enable cscope quickfix
set cscopequickfix=s-,c-,d-,i-,t-,e- "

" wildignore
set wildignore+=*cscope*
set wildignore+=tags

" -------------------------------------------------------------------------------------------------
" CUSTOMIZATIONS
" -------------------------------------------------------------------------------------------------
" add extra syntax highlighting for c functions and extra keywords
function! EnhanceCSyntax() abort
    syntax match cFunction /\w\+\s*(/me=e-1,he=e-1
    syntax keyword customType tUint32 tUint16 tUint8 tInt32 tInt16 tInt8 tBoolean
    syntax keyword cBoolean true false TRUE FALSE
    highlight def link cFunction Function
    highlight def link customType cType
    highlight def link cBoolean Boolean
endfunction
augroup c_syntax_enhancements
    autocmd!
    autocmd Syntax c call EnhanceCSyntax()
    autocmd Syntax cpp call EnhanceCSyntax()
augroup end

" autoload cscope database
function! LoadCscope() abort
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
        let path = strpart(db, 0, match(db, "/cscope.out$"))
        set nocscopeverbose
        exe "cs add " . db . " " . path
        set cscopeverbose
    endif
endfunction
augroup cscope
    autocmd!
    autocmd BufEnter /* call LoadCscope()
augroup end

" set correct make program and compiler for c projects
augroup c_make
    autocmd!
    autocmd Filetype c,cpp,yang setlocal makeprg=mk\ cpm\ i386
    autocmd Filetype c,cpp,yang :compiler gcc
augroup end

" automatically cleanup fugitive buffers
augroup fugitive
    autocmd!
    autocmd BufReadPost fugitive://* set bufhidden=delete
augroup end

" source vimrc on save
augroup vimrc
    autocmd!
    autocmd BufWritePost .vimrc source $MYVIMRC
augroup end

" automatically save when a file is changed
augroup auto_save_and_read
    autocmd!
    autocmd TextChanged, InsertLeave, FocusLost * silent! wall
    autocmd CursorHold * silent! checktime
augroup end

" set colorscheme
try
    colorscheme jellybeans
    let g:airline_theme='jellybeans'
catch
endtry

" -------------------------------------------------------------------------------------------------
" ABBREVIATIONS
" -------------------------------------------------------------------------------------------------
" use H to open help in a vertical split
cnoreabbrev H vert h

" -------------------------------------------------------------------------------------------------
" CUSTOM KEY MAPPINGS
" -------------------------------------------------------------------------------------------------
" map jj to esc
inoremap jj <Esc>

" map ; to :
nnoremap ; :

" edit read only files
cnoremap w!! w !sudo tee % >/dev/null

" cscope keymaps
nnoremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" omnicompletion
inoremap <C-o> <C-x><C-o>

" -------------------------------------------------------------------------------------------------
" LEADER KEY MAPPINGS
" -------------------------------------------------------------------------------------------------
" use space as leader
let mapleader=" "

" redraw the screen, clear search highlighting and force updating syntax highlighting
nnoremap <silent> <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" quickly open vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" delete trailing whitespace on a line
nnoremap <leader>dd :s/\s\+$//e<cr>

" remap ctrl-w
nnoremap <leader>w <C-w>

" async make
nnoremap <leader>m :Make<cr>

" toggle quickfix window
nnoremap <silent> <leader>qo :copen<cr>
nnoremap <silent> <leader>qc :cclose<cr>

" search files in the working directory
nnoremap <leader>oo :Files<CR>

" regex tags search
nnoremap <leader>tt :tj /

" grep what is under the cursor, don't return to allow to pass options
nnoremap <leader>gr :Ack <C-R>=expand("<cword>")<CR>

" tag jump taking cscope (and ctags) into account
nnoremap <leader>] :cstag <C-R>=expand("<cword>")<CR><CR>

" paste last yanked text
nnoremap <leader>pp "0p
vnoremap <leader>pp "0p

" replace word with last yanked text
nnoremap <leader>pr viw"0p

" run macro in register q
nnoremap <leader><leader> @q

" yank to system clipboard in visual mode
vnoremap <leader>y "*y

" paste from system clipboard
nnoremap <leader>ps "+p
