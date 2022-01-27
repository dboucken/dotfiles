#!/usr/bin/env bash
#
# Uninstall dotfiles.

# Unlink dotfiles
rm -v $HOME/.inputrc
rm -v $HOME/.tmux.conf
rm -v $HOME/.vimrc

# Remove bashrc
sed -i '/source.*bashrc/d' $HOME/.bashrc
sed -i '/source.*zshrc/d' $HOME/.zshrc

# Remove created directories
rm -rf $HOME/.vim/undo
