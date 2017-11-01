#!/bin/bash

echo " "
echo "################################################################################"
echo "# Start installation/update                                                    #"
echo "################################################################################"

cd ~

sh ~/dotfiles/install/dotfiles.sh
sh ~/dotfiles/install/git-scripts.sh

mkdir tools
cd tools

sh ~/dotfiles/install/tmux.sh
sh ~/dotfiles/install/vim.sh

cd ~

echo " "
echo "################################################################################"
echo "# Installation/update finished                                                 #"
echo "################################################################################"
