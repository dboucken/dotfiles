#!/bin/bash

echo " "
echo "################################################################################"
echo "# Uninstall git scripts                                                        #"
echo "################################################################################"

# Go to home directory and push the current directory to the stack
pushd ~

# Remove scripts
rm -v git-prompt.sh 2> /dev/null
rm -v git-completion.bash 2> /dev/null

# Return to the current directory
popd
