#!/usr/bin/env bash
#
# Update dotfiles. This script should be run from the dotfiles directory.

git pull
git submodule update --remote --merge
vim -c "helptags ALL" -c "qa"
