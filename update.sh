#!/usr/bin/env bash
#
# Update dotfiles. This script should be run from the dotfiles directory.
git pull

# Update base16-shell themes
git -C $HOME/.config/base16-shell pull

# Update VIM plugins
for dir in $HOME/.vim/pack/plugins/start/*
do
    git -C $dir pull
done
vim -c "helptags ALL" -c "qa"
