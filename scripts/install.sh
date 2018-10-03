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
    brew install tmux
    brew install vim --with-override-system-vi

    brew cask install appcleaner
    brew cask install stellarium
    brew cask install docker
    brew cask install sketchup

    # Update homebrew and cleanup
    brew update
    brew upgrade
    brew cleanup
    brew prune
fi

echo " "
echo "################################################################################"
echo "# Install bashrc                                                               #"
echo "################################################################################"

cd ~

# Source the repository bashrc in the correct home directory bashrc or bash_profile file
if [ -f ".bashrc" ]
then
    echo source ~/dotfiles/.bashrc >> ~/.bashrc
    echo "Append repository .bashrc to home directory .bashrc"
elif [ -f ".bash_profile" ]
then
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
        ./configure --with-features=huge --enable-python3interp=yes --enable-pythoninterp=yes
        make
        chmod a+rwx runtime/doc
        sudo make install

        # Install vim-plug
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

        # Install and update plugins
        vim +PlugClean! +PlugUpgrade +PlugUpdate +qall
    fi
fi

echo " "
echo "################################################################################"
echo "# Install finished                                                             #"
echo "################################################################################"
