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
rm -rf $HOME/.vim/pack/plugins

# Remove base16-shell
rm -rf $HOME/.config/base16-shell/
rm -f $HOME/.base16_theme
rm -f $HOME/.vimrc_background
