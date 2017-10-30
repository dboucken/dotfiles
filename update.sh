#!/bin/bash

if [ ! -d "$TOOLS_DIR" ]; then
    tools_dir="tools"
else
    tools_dir=$TOOLS_DIR
fi
echo "Use target folder $tools_dir"
tmux_dir="tmux"
vim_dir="vim"

cd ~

# Tools directory must exist
if [ ! -d "$tools_dir" ]; then
    echo "~/$tools_dir not found"
    return
fi

if [ ! -d "dotfiles" ]; then
    echo "dotfiles not found"
    exit
fi

echo " "
echo "################################################################################"
echo "# Update dotfiles                                                              #"
echo "################################################################################"
cd dotfiles
git pull
cd ~
if [ -f ".bash_profile" ]; then
    source .bash_profile
fi
if [ -f ".bashrc" ]; then
    source .bashrc
fi

echo "################################################################################"
echo "# Update git scripts                                                           #"
echo "################################################################################"
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O git-prompt.sh
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O git-completion.bash

cd $tools_dir

if [ -d "$tmux_dir" ]; then
    echo " "
    echo "################################################################################"
    echo "# Update Tmux                                                                  #"
    echo "################################################################################"
    cd $tmux_dir

    # Get current version
    current_tag=$(git describe --tags --abbrev=0)
    current_tag_commit=$(git rev-list -n 1 $current_tag)
    echo "Current tag: $current_tag ($current_tag_commit)"

    # Update repo
    git checkout master
    git pull

    # Get new version
    latest_tag=$(git describe --tags --abbrev=0)
    git checkout $latest_tag &>/dev/null
    latest_tag_commit=$(git rev-list -n 1 $latest_tag)
    echo "Latest tag: $latest_tag ($latest_tag_commit)"

    # Build and install if there is a new version or the force flag is set
    if [ "$current_tag" != "$latest_tag" ] || [ "$current_tag_commit" != "$latest_tag_commit" ]; then
        make && sudo make install
    fi
fi

cd ~
cd $tools_dir

if [ -d "$vim_dir" ]; then
    echo " "
    echo "################################################################################"
    echo "# Update Vim                                                                   #"
    echo "################################################################################"
    cd $vim_dir

    # Get current version
    current_tag=$(git describe --all)
    current_tag_commit=$(git rev-list -n 1 $current_tag)
    echo "Current tag: $current_tag ($current_tag_commit)"

    # Update repo
    git checkout master
    git pull

    # Get new version
    latest_tag=$(git describe --tags --abbrev=0)
    git checkout $latest_tag &>/dev/null
    latest_tag_commit=$(git rev-list -n 1 $latest_tag)
    echo "Latest tag: $latest_tag ($latest_tag_commit)"

    # Build and install if there is a new version or the force flag is set
    if [ "$current_tag" != "$latest_tag" ] || [ "$current_tag_commit" != "$latest_tag_commit" ]; then
        make && sudo make install
    fi

    echo " "
    echo "--------------------------------------------------------------------------------"
    echo " Update Vim Plugins (vim +PlugUpdate +PlugUpgrade +qall)"
    echo "--------------------------------------------------------------------------------"
    vim +PlugClean +PlugUpgrade +PlugUpdate +qall
fi

cd ~

echo " "
echo "################################################################################"
echo "# Update finished                                                              #"
echo "################################################################################"
