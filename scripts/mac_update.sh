#!/bin/bash

echo " "
echo "################################################################################"
echo "# Start update                                                                 #"
echo "################################################################################"

# Ask for administrator password upfront
sudo -v

sh ~/dotfiles/scripts/update/mac.sh
sh ~/dotfiles/scripts/update/dotfiles.sh
sh ~/dotfiles/scripts/install/git-scripts.sh
sh ~/dotfiles/scripts/update/tmux.sh
sh ~/dotfiles/scripts/update/vim.sh

echo " "
echo "################################################################################"
echo "# Update finished                                                              #"
echo "################################################################################"
