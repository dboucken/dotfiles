#!/usr/bin/env bash
#
# Install dotfiles. This script should be run from the dotfiles directory.

# Link dotfiles
ln -sv $PWD/inputrc $HOME/.inputrc
ln -sv $PWD/tmux.conf $HOME/.tmux.conf
ln -sv $PWD/vim $HOME/.vim

# Source bashrc
echo "source ${PWD}/bashrc" >> $HOME/.bashrc

# Make necessary directories
mkdir -p $HOME/.vim/undo
