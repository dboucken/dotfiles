#!/usr/bin/env bash
#
# Install dotfiles. This script should be run from the dotfiles directory.

git pull

vim -c PlugClean! -c PlugUpgrade -c PlugUpdate -c qall
