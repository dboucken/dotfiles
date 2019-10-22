#!/usr/bin/env bash
#
# Uninstall dotfiles.

# Unlink dotfiles
rm -v $HOME/.inputrc
rm -v $HOME/.tmux.conf
rm -v $HOME/.vimrc

# Remove bashrc
sed -i '/source.*bashrc/d' $HOME/.bashrc

# Remove created directories
rm -rf $HOME/.vim/undo

# Uninstall vim-plug
rm -v $HOME/.vim/autoload/plug.vim
rm -rf $HOME/.vim/plugged

# Uninstall base16-shell
rm -rf $HOME/.config/base16-shell
rm -v $HOME/.vimrc_background
rm -v $HOME/.base16_theme
