" -------------------------------------------------------------------------------------------------
" PLUGIN MANAGER
" -------------------------------------------------------------------------------------------------
" install vim-plug if it is not installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd vimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins should be added after this line
call plug#begin()

" color schemes
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'nanotech/jellybeans.vim'
Plug 'sjl/badwolf'

" plugins
Plug 'vim-airline/vim-airline'                              " enhanced status line
Plug 'vim-airline/vim-airline-themes'                       " status line color themes
Plug 'tpope/vim-fugitive'                                   " git wrapper
Plug 'airblade/vim-gitgutter'                               " show git diff in gutter
Plug 'nathanalderson/yang.vim',     { 'for': 'yang' }       " yang syntax highlighting
Plug 'tpope/vim-surround'                                   " all about surroundings
Plug 'tpope/vim-commentary'                                 " commenting
Plug 'pangloss/vim-javascript',     { 'for': 'javascript' } " better javascript support
Plug 'w0rp/ale',                    { 'for': 'javascript' } " aync linting plugin
Plug 'tpope/vim-unimpaired'                                 " some useful key mappings
Plug 'sedan07/vim-mib',             { 'for': 'mib' }        " mib syntax highlighting
Plug 'dkprice/vim-easygrep'                                 " project wide search/replace
Plug 'tpope/vim-dispatch'                                   " async make
Plug 'kien/ctrlp.vim'                                       " fuzzy file finder
Plug 'FelikZ/ctrlp-py-matcher'                              " faster matcher for ctrlp
Plug 'godlygeek/tabular'                                    " align text

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
set scrolloff=7                 " set 7 lines to the cursor when moving vertically
set cmdheight=2                 " increase the height of the command bar
set nowrap                      " dont't wrap
set laststatus=2                " always show the status line
set completeopt=longest,menuone " better autocompletion
set mouse=a                     " enable mouse support
set autowriteall                " autosave files
set noshowmode                  " don't show mode as we use a status line plugin

" tabs and indentation
set tabstop=4     " number of visual spaces per tab
set softtabstop=4 " number of spaces per tab when editing
set expandtab     " tabs are spaces
set shiftround    " round to multiple of shiftwidth when adjusting indentation
set shiftwidth=4  " number of spaces for each step of autoindent
set autoindent    " auto indent on a new line

" line numbers
set number         " enable line numbers
set relativenumber " handy relative line numbers

" key timeouts
set notimeout       " quickly time out on keycodes, but never time out on mappings
set ttimeout        " quickly time out on keycodes, but never time out on mappings
set ttimeoutlen=200 " quickly time out on keycodes, but never time out on mappings

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

" cscope
set cscopequickfix=s-,c-,d-,i-,t-,e- " enable cscope quickfix

" wildignore
set wildignore+=*cscope*
set wildignore+=tags

" -------------------------------------------------------------------------------------------------
" PLUGIN SETTINGS
" -------------------------------------------------------------------------------------------------
" color scheme settings
set background=dark            " use a dark background colour
let g:solarized_termcolors=256 " enhance solarized terminal colours
let g:rehash256=1              " enhance molokai terminal colours
colorscheme jellybeans         " default colour scheme

" airline config
let g:airline_theme='jellybeans'

" easy grep open search and replace matches not in a new tab
let g:EasyGrepReplaceWindowMode=2

" ctrlp settings
let g:ctrlp_use_caching=0
let g:ctrlp_by_filename=1
let g:ctrlp_use_caching=0
let g:ctrlp_max_files=0
let g:ctrlp_lazy_update=125
let g:ctrlp_match_window='bottom,order:btt,min:1,max:10,results:50'
let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git', 'cd %s && git ls-files . -co --exclude-standard'],
        \ },
    \ 'fallback': 'find %s -type f'
    \ }
let g:ctrlp_match_func={ 'match': 'pymatcher#PyMatch' }

" -------------------------------------------------------------------------------------------------
" CUSTOMIZATIONS
" -------------------------------------------------------------------------------------------------
" automatically open quickfix window
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost * cwindow
augroup END

" add syntax highlighting for c functions
function! EnhanceCSyntax()
    syntax match cFunction /\w\+\s*(/me=e-1,he=e-1
    syntax keyword customType tUint32 tUint16 tUint8 tInt32 tInt16 tInt8 tBoolean
    syntax keyword cBoolean true false TRUE FALSE
    highlight def link cFunction Function
    highlight def link customType cType
    highlight def link cBoolean Boolean
endfunction
augroup syntax_enhancements
    autocmd!
    autocmd Syntax c call EnhanceCSyntax()
    autocmd Syntax cpp call EnhanceCSyntax()
augroup END

" autoload cscope database
function! LoadCscope()
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
augroup END

" set correct make program and compiler for c projects
augroup make
    autocmd!
    autocmd Filetype c,cpp,yang set makeprg=mk\ cpm\ i386
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

" -------------------------------------------------------------------------------------------------
" CUSTOM KEY MAPPINGS
" -------------------------------------------------------------------------------------------------
" map jj to esc
:inoremap jj <Esc>

" map ; to :
:nnoremap ; :

" edit read only files
:cnoremap sudow w !sudo tee % >/dev/null

" cscope keymaps
nnoremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" -------------------------------------------------------------------------------------------------
" LEADER KEY MAPPINGS
" -------------------------------------------------------------------------------------------------
" use space as leader
let mapleader=" "

" clear the highlighting of :set hlsearch
nnoremap <silent> <leader>l :nohlsearch<cr>

" quickly open vimrc
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" delete trailing whitespace on a line
:nnoremap <leader>dd :s/\s\+$//e<cr>

" search and replace word under cursor in a file
:nnoremap <leader>sr :%s/\<<C-r><C-w>\>//g<left><left>

" remap ctrl-w
:nnoremap <leader>w <C-w>

" make
:nnoremap <leader>m :Make
