#!/bin/bash

echo " "
echo "################################################################################"
echo "# Install git scripts                                                          #"
echo "################################################################################"

# Goto home directory and push the current directory to the stack
pushd ~

# Install or update the git scripts
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O git-prompt.sh
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O git-completion.bash

# Source the repository bashrc in the correct home directory bashrc or bash_profile file
if [ -f ".bashrc" ]; then
    echo "GIT_PROMPT_ONLY_IN_REPO=1" >> ~/.bashrc
    echo source ~/git-prompt.sh >> ~/.bashrc
    echo source ~/git-completion.bash >> ~/.bashrc
    echo "Source git scripts in bashrc."
elif [ -f ".bash_profile" ]; then
    echo "GIT_PROMPT_ONLY_IN_REPO=1" >> ~/.bash_profile
    echo source ~/git-prompt.sh >> ~/.bash_profile
    echo source ~/git-completion.bash >> ~/.bash_profile
    echo "Source git scripts in bash_profile."
fi

# Return to the current directory
popd
