#!/usr/bin/env bash
#
# Uninstall dotfiles.

# Unlink dotfiles
rm -v $HOME/.inputrc
rm -v $HOME/.tmux.conf
rm -v $HOME/.vimrc
rm -v $HOME/.config/nvim/init.lua

# Remove bashrc
sed -i '/source.*bashrc/d' $HOME/.bashrc

# Remove base16-shell
rm -rf ~/.base16_theme
rm -rf ~/.vimrc_background
rm -rf ~/.config/base16-shell/

# Remove Neovim plugins
rm -rf ~/.local/share/nvim/site/pack/packer/

# Remove created directories
rm -rf $HOME/.vim/undo
