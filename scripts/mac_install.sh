#!/bin/bash

echo " "
echo "################################################################################"
echo "# Start installation/update                                                    #"
echo "################################################################################"

cd ~

sh ~/dotfiles/scripts/install/dotfiles.sh
sh ~/dotfiles/scripts/install/git-scripts.sh

mkdir tools
cd tools

sh ~/dotfiles/scripts/install/tmux.sh
sh ~/dotfiles/scripts/install/vim.sh

cd ~

sh ~/dotfiles/scripts/install/mac.sh

echo " "
echo "################################################################################"
echo "# Installation/update finished                                                 #"
echo "################################################################################"
