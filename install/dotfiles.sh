echo " "
echo "################################################################################"
echo "# Install/update dotfiles                                                      #"
echo "################################################################################"

# Update dotfiles
cd ~/dotfiles
git pull

cd ~

# Link to dotfiles
ln -sv dotfiles/.vimrc
ln -sv dotfiles/.tmux.conf
ln -sv dotfiles/.inputrc
