#!/bin/bash

echo " "
echo "################################################################################"
echo "# Start uninstallation                                                         #"
echo "################################################################################"

# Ask for administrator password upfront
sudo -v

sh ~/dotfiles/scripts/uninstall/dotfiles.sh
sh ~/dotfiles/scripts/uninstall/git-scripts.sh
sh ~/dotfiles/scripts/uninstall/tmux.sh
sh ~/dotfiles/scripts/uninstall/vim.sh

echo " "
echo "################################################################################"
echo "# Uninstallation finished                                                      #"
echo "################################################################################"
