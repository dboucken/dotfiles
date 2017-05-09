" -------------------------------------------------------------------------------------------------
" PLUGIN MANAGER
" -------------------------------------------------------------------------------------------------
filetype off    " disable filetype detection, required for vundle

set rtp+=~/.vim/bundle/Vundle.vim   " vundle plugin manager
call vundle#begin()

" plugins should be added after this line, it is required that vundle manages vundle
" setup vundle before running PluginInstall:
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
Plugin 'VundleVim/Vundle.vim'

" color schemes
Plugin 'morhetz/gruvbox'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'nanotech/jellybeans.vim'
Plugin 'sjl/badwolf'

" plugins
Plugin 'vim-airline/vim-airline'            " enhanced status bar
Plugin 'tpope/vim-fugitive'                 " git wrapper
Plugin 'kien/ctrlp.vim'                     " fuzzy file finder
Plugin 'airblade/vim-gitgutter'             " show git diff in gutter
Plugin 'nathanalderson/yang.vim'            " yang syntax highlighting
Plugin 'tpope/vim-surround'                 " all about surroundings
Plugin 'tpope/vim-commentary'               " commenting
Plugin 'pangloss/vim-javascript'            " better javascript support
Plugin 'w0rp/ale'                           " aync linting plugin

call vundle#end()   " vundle plugins end, all plugins should be added before this line

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

" tabs and indentation
set tabstop=4       " number of visual spaces per tab
set softtabstop=4   " number of spaces per tab when editing
set expandtab       " tabs are spaces
set shiftround      " round to multiple of shiftwidth when adjusting indentation
set shiftwidth=4    " number of spaces for each step of autoindent
set autoindent      " auto indent on a new line

" line numbers
set number          " enable line numbers
set relativenumber  " handy relative line numbers

" key timeouts
set notimeout       " quickly time out on keycodes, but never time out on mappings
set ttimeout        " quickly time out on keycodes, but never time out on mappings
set ttimeoutlen=200 " quickly time out on keycodes, but never time out on mappings

" non printable characters
set list                                                    " show non-printable characters
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+   " customize shown characters

" search
set incsearch   " search as characters are entered
set hlsearch    " highlight matches
set ignorecase  " ignore case when searching lowercase
set smartcase   " don't ignore case when inserting uppercase characters

" backups
set nobackup    " disable backups
set noswapfile  " disable swapfiles

" cscope
set cscopequickfix=s-,c-,d-,i-,t-,e-    " enable cscope quickfix

" make (need to review and cleanup errorformat)
set makeprg=mk\ cpm\ i386
set errorformat=%.%./%f:%l:%c:\ %trror:\ %m
set errorformat+=%.%./%f:%l:%c:\ %tarning:\ %m
set errorformat+=%f:%l:%c:\ %trror:\ %m
set errorformat+=%f:%l:%c:\ %tarning:\ %m
set errorformat+=%.%./%f:%l:\ %trror:\ %m
set errorformat+=%.%./%f:%l:\ %tarning:\ %m
set errorformat+=%f:%l:\ %trror:\ %m
set errorformat+=%f:%l:\ %tarning:\ %m

" -------------------------------------------------------------------------------------------------
" PLUGIN SETTINGS
" -------------------------------------------------------------------------------------------------
" color scheme settings
set background=dark             " use a dark background colour
let g:solarized_termcolors=256  " enhance solarized terminal colours
let g:rehash256=1               " enhance molokai terminal colours
colorscheme jellybeans          " default colour scheme

" ctrlp config
let g:ctrlp_by_filename=1   " search by filename as default

" ale disable c/cpp linting
let g:ale_linters = {
\   'c': [],
\   'cpp': [],
\}

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
" -------------------------------------------------------------------------------------------------
" CUSTOM KEY MAPPINGS
" -------------------------------------------------------------------------------------------------
" use <C-L> to clear the highlighting of :set hlsearch
nnoremap <C-L> :nohlsearch<CR>

" key mappings to quickly open and source vimrc
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" map jj to esc
:inoremap jj <Esc>

" delete trailing whitespace on a line
:nnoremap <leader>dd :s/\s\+$//e<cr>

" cscope keymaps
nnoremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
