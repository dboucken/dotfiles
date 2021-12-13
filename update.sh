#!/usr/bin/env bash
#
# Update dotfiles. This script should be run from the dotfiles directory.

git pull

vim -c "PlugClean!" -c "PlugUpgrade" -c "PlugUpdate" -c "qa"
