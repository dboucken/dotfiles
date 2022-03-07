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
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c "PlugInstall" -c "qa"
