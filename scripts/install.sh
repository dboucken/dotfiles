#!/bin/bash

echo " "
echo "################################################################################"
echo "# Start installation                                                           #"
echo "################################################################################"

# Ask for administrator password upfront
sudo -v

# Make sure we can execute the scripts
sudo chmod -R a+rwx ~/dotfiles

sh ~/dotfiles/scripts/install/bashrc.sh
sh ~/dotfiles/scripts/install/dotfiles.sh
sh ~/dotfiles/scripts/install/git-scripts.sh
sh ~/dotfiles/scripts/install/tmux.sh
sh ~/dotfiles/scripts/install/vim.sh

echo " "
echo "################################################################################"
echo "# Installation finished                                                        #"
echo "################################################################################"
