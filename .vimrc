" -------------------------------------------------------------------------------------------------
" SOURCE NEOVIM CONFIGURATION
" -------------------------------------------------------------------------------------------------
source ~/.config/nvim/init.vim

" -------------------------------------------------------------------------------------------------
" VIM SPECIFIC SETTINGS
" -------------------------------------------------------------------------------------------------

set autoindent                 " auto indent when inserting a new line
set autoread                   " reload a file when it is changed outside vim
set background=dark            " use a dark background
set backspace=indent,eol,start " allow backspacing over auto indent, line breaks, insert action
set complete-=i                " don't scan include files during insert mode auto completion
set formatoptions+=j           " delete comment character when joining lines
set hlsearch                   " highlight matches
set incsearch                  " search as characters are entered
set listchars=tab:>\ ,trail:-  " show tabs and trailing white space when list is enabled
set noswapfile                 " disable swap files
set notimeout                  " never timeout on mappings
set noundofile                 " disable undofile
set ruler                      " show line and column number in command line
set t_ut=                      " disable Background Color Erase (BCE)
set ttimeout                   " timeout on key codes
set ttimeoutlen=200            " timeout length on key codes
set wildmenu                   " visual auto complete for command menu
