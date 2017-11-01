if [ ! -d "tmux" ]; then
    echo " "
    echo "################################################################################"
    echo "# Install tmux                                                                 #"
    echo "################################################################################"

    git clone https://github.com/tmux/tmux.git tmux

    cd tmux

    # Use latest tag
    latest_tag=$(git describe --tags --abbrev=0)
    git checkout $latest_tag

    # Install
    sh autogen.sh && ./configure && make && sudo make install
else
    echo " "
    echo "################################################################################"
    echo "# Update tmux                                                                  #"
    echo "################################################################################"

    cd tmux

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
fi
