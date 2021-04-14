#!/usr/bin/env bash
#
# Update dotfiles. This script should be run from the dotfiles directory.

git pull
vim -c "PlugUpgrade" -c "qa"
vim -c "PlugUpdate" -c "qa"
