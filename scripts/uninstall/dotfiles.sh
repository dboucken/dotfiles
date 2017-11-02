#!/bin/bash

echo " "
echo "################################################################################"
echo "# Uninstall dotfiles                                                           #"
echo "################################################################################"

# Goto home directory and push the current directory to the stack
pushd ~

# Remove links
rm -v .vimrc
rm -v .tmux.conf
rm -v .inputrc

# Return to the current directory
popd
