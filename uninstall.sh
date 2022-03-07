#!/usr/bin/env bash
#
# Uninstall dotfiles.

# Unlink dotfiles
rm -v $HOME/.tmux.conf
rm -v $HOME/.vimrc

# Remove created directories
rm -rf $HOME/.vim/undo
rm -rf $HOME/.vim/plugged
rm -rf $HOME/.vim/autoload
