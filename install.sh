#!/usr/bin/env bash
#
# Install dotfiles. This script should be run from the dotfiles directory.

# Make necessary directories
mkdir -p $HOME/.vim/undo
mkdir -p $HOME/.config/nvim

# Link dotfiles
ln -sv $PWD/inputrc $HOME/.inputrc
ln -sv $PWD/tmux.conf $HOME/.tmux.conf
ln -sv $PWD/vimrc $HOME/.vimrc
ln -sv $PWD/init.lua $HOME/.config/nvim/init.lua

# Install base16-shell
rm -rf ~/.config/base16-shell
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# Source bashrc
echo "source ${PWD}/bashrc" >> $HOME/.bashrc

# Install vim plugins
vim -c "PlugInstall" -c "qa"

# Install neovim plugins
rm -rf ~/.local/share/nvim/site/pack/packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
