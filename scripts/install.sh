#!/bin/bash

echo " "
echo "################################################################################"
echo "# Start install                                                                #"
echo "################################################################################"

# Ask for administrator password upfront
sudo -v

# Make sure we can execute the scripts
sudo chmod -R a+rwx ~/dotfiles

# Mac specific scripts
os="$(uname -s)"

if [ "$os" == "Darwin" ]
then
    echo "Mac specific scripts."

    sudo xcodebuild -license accept

    # Install homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # Install cask
    brew tap caskroom/cask

    brew update
    brew upgrade

    # Install packages
    brew install git
    brew install bash
    brew install bash-completion
    brew install python3
    brew install cscope
    brew install ctags
    brew install markdown
    brew install openconnect
    brew install wget
    brew install automake
    brew install pkg-config
    brew install libevent
    brew install ripgrep
    brew install vim
    brew install tmux

    brew cask install appcleaner
    brew cask install filezilla
    brew cask install sketchup
    brew cask install stellarium
    brew cask install docker
    brew cask install dhs
    brew cask install malwarebytes
    brew cask install oversight
    brew cask install pixum-fotowereld

    # brew cask install google-chrome
    # brew cask install spotify
    # brew cask install google-backup-and-sync

    # Update homebrew and cleanup
    brew update
    brew upgrade
    brew cleanup
    brew cask cleanup
    brew prune
fi

echo " "
echo "################################################################################"
echo "# Install git scripts                                                          #"
echo "################################################################################"

cd ~

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

echo " "
echo "################################################################################"
echo "# Install bashrc                                                               #"
echo "################################################################################"

# Source the repository bashrc in the correct home directory bashrc or bash_profile file
if [ -f ".bashrc" ]; then
    echo source ~/dotfiles/.bashrc >> ~/.bashrc
    echo "Append repository .bashrc to home directory .bashrc"
elif [ -f ".bash_profile" ]; then
    echo source ~/dotfiles/.bashrc >> ~/.bash_profile
    echo "Append repository .bashrc to home directory .bash_profile"
fi

echo " "
echo "################################################################################"
echo "# Install dotfiles                                                             #"
echo "################################################################################"

cd ~/dotfiles

# Update dotfiles
git pull

# Update submodules
git submodule update --remote --merge --recursive --init

# Link to dotfiles
cd ~
ln -sv ~/dotfiles/.vimrc
ln -sv ~/dotfiles/.tmux.conf
ln -sv ~/dotfiles/.inputrc

# Install tools on linux
if [ "$os" != "Darwin" ]
then
    # Try create tools directory for case that it does not already exists
    mkdir ~/tools 2> /dev/null

    cd ~/tools

    if [ ! -d "tmux" ]
    then
        echo " "
        echo "################################################################################"
        echo "# Install tmux                                                                 #"
        echo "################################################################################"

        # Clone the tmux repository
        git clone https://github.com/tmux/tmux.git tmux

        cd tmux

        # Use latest tag
        latest_tag=$(git describe --tags --abbrev=0)
        git checkout $latest_tag

        # Configure, build and install
        sh autogen.sh && ./configure && make && sudo make install
    fi

    cd ~/tools

    if [ ! -d "vim" ]
    then
        echo " "
        echo "################################################################################"
        echo "# Install Vim                                                                  #"
        echo "################################################################################"

        # Clone the vim repository
        git clone https://github.com/vim/vim.git vim

        cd vim

        # Configure, build and install vim
        ./configure --with-features=huge && make && chmod a+rwx runtime/doc && sudo make install

        # Try create .vim directory for case that it does not already exists
        mkdir ~/.vim 2> /dev/null

        # Make a link to the plugin directory
        ln -vs ~/dotfiles/vim/pack ~/.vim/pack
    fi
fi

echo " "
echo "################################################################################"
echo "# Install finished                                                             #"
echo "################################################################################"
