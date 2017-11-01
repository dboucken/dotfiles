if [ ! -d "tmux" ]; then
    exit
fi

echo " "
echo "################################################################################"
echo "# Uninstall Tmux                                                               #"
echo "################################################################################"
cd tmux
sudo make uninstall
cd ..
rm -vrf tmux

# Remove tmux related directories and files in the home directory
rm -rfv ~/.tmux
