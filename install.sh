#!/usr/bin/env bash
#
# Install dotfiles. This script should be run from the dotfiles directory.

# Make necessary directories
mkdir -p $HOME/.vim/undo
mkdir -p $HOME/.vim/pack/plugins

# Link dotfiles
ln -sv $PWD/inputrc $HOME/.inputrc
ln -sv $PWD/tmux.conf $HOME/.tmux.conf
ln -sv $PWD/vimrc $HOME/.vimrc
ln -sv $PWD/vim-plugins $HOME/.vim/pack/plugins/start

# Source bashrc
echo "source ${PWD}/bashrc" >> $HOME/.bashrc

# Install vim plugins
git submodule update --init
vim -c "helptags ALL" -c "qa"
