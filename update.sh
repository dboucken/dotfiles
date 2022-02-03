#!/usr/bin/env bash
#
# Update dotfiles. This script should be run from the dotfiles directory.

git pull

vim -c "PlugClean!" -c "PlugUpgrade" -c "PlugUpdate" -c "qa"

# Update base16-shell themes
pushd $HOME/.config/base16-shell
git pull
popd
