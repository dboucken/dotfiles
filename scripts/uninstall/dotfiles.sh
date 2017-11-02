#!/bin/bash

echo " "
echo "################################################################################"
echo "# Uninstall dotfiles                                                           #"
echo "################################################################################"

# Goto home directory and push the current directory to the stack
pushd ~

# Remove links
rm -v .vimrc 2> /dev/null
rm -v .tmux.conf 2> /dev/null
rm -v .inputrc 2> /dev/null

# Return to the current directory
popd
