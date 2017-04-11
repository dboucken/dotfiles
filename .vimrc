" be IMproved
set nocompatible

" disable filetype detection, required for vundle
filetype off

" enable syntax highlighting
syntax on

" set tabs to 4 spaces
set tabstop=4
set softtabstop=4
set expandtab
set shiftround

" auto indent on a new line
set autoindent

" show line numbers
set number

" show last command in bottom bar
set showcmd

" highlight current line
set cursorline

" set vertical line at 100 characters
set colorcolumn=100

" show current position in bottom bar
set ruler

" visual autocomplete for command menu
set wildmenu

" always report changed lines
set report=0

" only syntax highlight the first 250 columns
set synmaxcol=250

" only redraw when necessary
set lazyredraw
set ttyfast

" quickly time out on keycodes, but never time out on mappings
set notimeout
set ttimeout
set ttimeoutlen=200

" reload file when changed outside vim
set autoread

" show matching brackets
set showmatch

" show as much as possible of the last line
set display+=lastline

" open new windows below and to the right
set splitbelow
set splitright

" non-printable characters
set list
if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" search incrementally and highlight search results
set incsearch
set hlsearch

" use <C-L> to clear the highlighting of :set hlsearch
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" ignore cases when searching lower case, don't otherwise
set ignorecase
set smartcase

" increase history and undo levels
set history=1000
set undolevels=1000

" disable sounds
set visualbell
set noerrorbells

" allow backspacing over autoindent, line breaks and insert action
set backspace=indent,eol,start

" disable backups
set nobackup
set noswapfile

" buffer becomes hidden when it is abandoned
set hidden

" set 7 lines to the cursor when moving vertically
set scrolloff=7

" increase the height of the command bar
set cmdheight=2

" dont't wrap
set nowrap

" always show the status line
set laststatus=2

" enable the use of the mouse in all modes
set mouse=a

" vundle plugin manager
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" plugins should be added after this line, it is required that vundle manages vundle
" setup vundle before running PluginInstall:
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
Plugin 'VundleVim/Vundle.vim'

" color schemes
Plugin 'morhetz/gruvbox'
Plugin 'altercation/vim-colors-solarized'

" enhanced status bar
Plugin 'vim-airline/vim-airline'

" git wrapper
Plugin 'tpope/vim-fugitive'

" fuzzy file finder
Plugin 'kien/ctrlp.vim'

" show git diff in gutter
Plugin 'airblade/vim-gitgutter'

" yang syntax highlighting
Plugin 'nathanalderson/yang.vim'

" Syntax highlighting for tags
Plugin 'TagHighlight'

" syntax checking
Plugin 'scrooloose/syntastic'

" vundle plugins end, all plugins should be added before this line
call vundle#end()

" attempt to determine file type
filetype plugin indent on

" dark color scheme
set background=dark
let g:solarized_termcolors=256
colorscheme gruvbox

" Set file type explicitely for yang files
autocmd BufNewFile,BufRead *.yang set syntax=yang

" cscope keymaps
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
