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

# Remove base16-shell
rm -rfv $HOME/.config/base16-shell/
