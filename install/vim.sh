if [ ! -d "vim" ]; then
    echo " "
    echo "################################################################################"
    echo "# Install Vim                                                                  #"
    echo "################################################################################"

    git clone https://github.com/vim/vim.git vim

    cd vim

    ./configure --with-features=huge && make && chmod a+rwx runtime/doc && sudo make install

    echo " "
    echo "--------------------------------------------------------------------------------"
    echo " Install Vim Plugins"
    echo "--------------------------------------------------------------------------------"
    vim +PlugUpdate +PlugUpgrade +qall
else
    echo " "
    echo "################################################################################"
    echo "# Update Vim                                                                   #"
    echo "################################################################################"
    cd vim

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

    # Build and install if there is a new version
    if [ "$current_tag_commit" != "$latest_tag_commit" ]; then
        make && sudo make install
    fi

    echo " "
    echo "--------------------------------------------------------------------------------"
    echo " Update Vim Plugins"
    echo "--------------------------------------------------------------------------------"
    vim +PlugClean +PlugUpgrade +PlugUpdate +qall
fi
