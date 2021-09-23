#!/usr/bin/env bash
#
# Update dotfiles. This script should be run from the dotfiles directory.

git pull

vim -c "PlugClean!" -c "qa"
vim -c "PlugUpgrade" -c "qa"
vim -c "PlugUpdate" -c "qa"

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
