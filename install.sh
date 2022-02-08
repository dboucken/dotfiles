#!/usr/bin/env bash
#
# Install dotfiles. This script should be run from the dotfiles directory.

# Make necessary directories
mkdir -p $HOME/.vim/undo
mkdir -p $HOME/.vim/pack/plugins/start

# Link dotfiles
ln -sv $PWD/tmux.conf $HOME/.tmux.conf
ln -sv $PWD/vimrc $HOME/.vimrc

# Install VIM plugins
pushd $HOME/.vim/pack/plugins/start
git clone https://github.com/airblade/vim-gitgutter
git clone https://github.com/tpope/vim-commentary
git clone https://github.com/tpope/vim-fugitive
git clone https://github.com/tpope/vim-unimpaired
popd
vim -c "helptags ALL" -c "qa"
