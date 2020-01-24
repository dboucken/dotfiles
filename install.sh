#!/usr/bin/env bash
#
# Install dotfiles. This script should be run from the dotfiles directory.

# Link dotfiles
ln -sv $PWD/inputrc $HOME/.inputrc
ln -sv $PWD/tmux.conf $HOME/.tmux.conf
ln -sv $PWD/vimrc $HOME/.vimrc

# Source bashrc
echo "source ${PWD}/bashrc" >> $HOME/.bashrc

# Make necessary directories
mkdir -p $HOME/.vim/undo

# Install vim-plug
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c PlugInstall -c qall
