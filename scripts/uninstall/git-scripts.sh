#!/bin/bash

echo " "
echo "################################################################################"
echo "# Uninstall git scripts                                                        #"
echo "################################################################################"

# Goto home directory and push the current directory to the stack
pushd ~

# Remove scripts
rm -v git-prompt.sh
rm -v git-completion.bash

# Return to the current directory
popd