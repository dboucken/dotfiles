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
echo "# Uninstall dotfiles                                                           #"
echo "################################################################################"

# Remove links
if [ -h ".vimrc" ]; then
    rm -vf .vimrc
fi
if [ -h ".tmux.conf" ]; then
    rm -vf .tmux.conf
fi
if [ -h ".inputrc" ]; then
    rm -vf .inputrc
fi

# Restore backups
if [ -f ".vimrc.bak" ]; then
    mv -vf .vimrc.bak .vimrc
fi
if [ -f ".tmux.conf.bak" ]; then
    mv -vf .tmux.conf.bak .tmux.conf
fi
if [ -f ".inputrc.bak" ]; then
    mv -vf .inputrc.bak .inputrc
fi

echo "################################################################################"
echo "# Uninstall git scripts                                                        #"
echo "################################################################################"
if [ -f "git-prompt.sh" ]; then
    rm -rfv git-prompt.sh
fi
if [ -f "git-completion.bash" ]; then
    rm -rfv git-completion.bash
fi

# Tools directory must exist
if [ ! -d "$tools_dir" ]; then
    echo "~/$tools_dir not found"
    return
fi

cd $tools_dir

if [ -d "$tmux_dir" ]; then
    echo " "
    echo "################################################################################"
    echo "# Uninstall Tmux                                                               #"
    echo "################################################################################"
    cd $tmux_dir
    sudo make uninstall
    cd ..
    rm -rf $tmux_dir
fi

cd ~

# Remove tmux related directories and files in the home directory
if [ -d ".tmux" ]; then
    rm -rfv .tmux
fi

cd $tools_dir

if [ -d "$vim_dir" ]; then
    echo " "
    echo "################################################################################"
    echo "# Uninstall Vim                                                                #"
    echo "################################################################################"
    cd $vim_dir
    sudo make uninstall
    cd ..
    rm -rf $vim_dir
fi

cd ~

# Remove vim related directories and files in the home directory
if [ -d ".vim" ]; then
    rm -rfv .vim
fi

if [ -f ".viminfo" ]; then
    rm -rfv .viminfo
fi

echo " "
echo "################################################################################"
echo "# Uninstall finished                                                           #"
echo "################################################################################"
