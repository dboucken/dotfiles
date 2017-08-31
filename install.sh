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

echo "################################################################################"
echo "# Install dotfiles                                                             #"
echo "################################################################################"

# Backup existing dotfiles
if [ -f ".vimrc" ]; then
    mv -vf .vimrc .vimrc.bak
fi
if [ -f ".tmux.conf" ]; then
    mv -vf .tmux.conf .tmux.conf.bak
fi
if [ -f ".inputrc" ]; then
    mv -vf .inputrc .inputrc.bak
fi

# Link to new dotfiles
ln -sv dotfiles/.vimrc
ln -sv dotfiles/.tmux.conf
ln -sv dotfiles/.inputrc

# Create tools dir if it does not exist
if [ ! -d "$tools_dir" ]; then
    mkdir $tools_dir
fi

cd $tools_dir

if [ ! -d "$tmux_dir" ]; then
    echo " "
    echo "################################################################################"
    echo "# Install Tmux                                                                 #"
    echo "################################################################################"
    git clone https://github.com/tmux/tmux.git $tmux_dir
    cd $tmux_dir
    latest_tag=$(git describe --tags --abbrev=0)
    git checkout $latest_tag
    sh autogen.sh && ./configure && make && sudo make install
fi

cd ~
cd $tools_dir

if [ ! -d "$vim_dir" ]; then
    echo " "
    echo "################################################################################"
    echo "# Update Vim                                                                   #"
    echo "################################################################################"
    git clone https://github.com/vim/vim.git $vim_dir
    cd $vim_dir
    ./configure --with-features=huge && make && chmod a+rwx runtime/doc && sudo make install

    echo " "
    echo "--------------------------------------------------------------------------------"
    echo " Install Vim Plugins (vim +PlugUpdate +PlugUpgrade +qall)"
    echo "--------------------------------------------------------------------------------"
    vim +PlugUpdate +PlugUpgrade +qall
fi

cd ~

echo " "
echo "################################################################################"
echo "# Install finished                                                             #"
echo "################################################################################"
