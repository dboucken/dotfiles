" -------------------------------------------------------------------------------------------------
" SOURCE NVIM CONFIGURATION FILE
" -------------------------------------------------------------------------------------------------
source ~/dotfiles/init.vim

" -------------------------------------------------------------------------------------------------
" VIM specific settings
" -------------------------------------------------------------------------------------------------
runtime! ftplugin/man.vim         " read man pages in vim via :Man <command>
set autoindent                    " auto indent when inserting a new line
set autoread                      " reload a file when it is changed outside vim
set backspace=indent,eol,start    " allow backspacing over auto indent, line breaks, insert action
set complete-=i                   " don't scan include files during insert mode auto completion
set hlsearch                      " highlight matches
set laststatus=2                  " always show the status line
set listchars=tab:>\ ,trail:-     " show tabs and trailing white space when list is enabled
set notermguicolors               " don't enable 24 bit colors
set ruler                         " show line and column number in the status line
set wildmenu                      " visual auto complete for command menu

" use terminal background when using jellybeans color scheme
let g:jellybeans_overrides = { 'background': { 'ctermbg': 'none', '256ctermbg': 'none' } }

" apply color scheme
colorscheme jellybeans
