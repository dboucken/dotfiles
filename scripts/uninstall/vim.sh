#!/bin/bash

echo " "
echo "################################################################################"
echo "# Uninstall Vim                                                                #"
echo "################################################################################"

# Goto vim directory and push the current directory to the stack
pushd ~/tools

# Vim must be installed
if [ ! -d "vim" ]; then
    echo "Vim not installed."
    # Return to the current directory
    popd
    exit
fi

cd vim

# Uninstall
sudo make uninstall

# Remove directory
rm -rf ~/tools/vim

# Remove vim related directories and files in the home directory
rm -rf ~/.vim
rm -rf ~/.viminfo

# Return to the current directory
popd
