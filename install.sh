#!/usr/bin/env bash
#
# Install dotfiles. This script should be run from the dotfiles directory.

# Make necessary directories
mkdir -p $HOME/.vim/undo

# Link dotfiles
ln -sv $PWD/inputrc $HOME/.inputrc
ln -sv $PWD/tmux.conf $HOME/.tmux.conf
ln -sv $PWD/vimrc $HOME/.vimrc

# Install base16-shell
git clone https://github.com/fnune/base16-shell.git ~/.config/base16-shell

# Source bashrc
echo "source ${PWD}/bashrc" >> $HOME/.bashrc

# Install vim plugins
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c "PlugInstall" -c "qa"
