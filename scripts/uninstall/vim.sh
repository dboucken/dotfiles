if [ ! -d "vim" ]; then
    exit
fi

echo " "
echo "################################################################################"
echo "# Uninstall Vim                                                                #"
echo "################################################################################"
cd vim
sudo make uninstall
cd ..
rm -vrf vim

# Remove vim related directories and files in the home directory
rm -rfv ~/.vim
rm -rfv ~/.viminfo
