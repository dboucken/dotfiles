#!/bin/bash

echo " "
echo "################################################################################"
echo "# Update git scripts                                                           #"
echo "################################################################################"

# Go to home directory and push the current directory to the stack
pushd ~

# Install or update the git scripts
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O git-prompt.sh
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O git-completion.bash

# Return to the current directory
popd
