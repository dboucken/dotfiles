#!/bin/bash

echo " "
echo "################################################################################"
echo "# Start uninstallation                                                         #"
echo "################################################################################"

cd ~

sh ~/dotfiles/scripts/uninstall/dotfiles.sh
sh ~/dotfiles/scripts/uninstall/git-scripts.sh

if [ -d "tools" ]; then
    cd tools

    sh ~/dotfiles/scripts/uninstall/tmux.sh
    sh ~/dotfiles/scripts/uninstall/vim.sh

    cd ~

    rm -vrf tools
fi

echo " "
echo "################################################################################"
echo "# Uninstallation finished                                                      #"
echo "################################################################################"
