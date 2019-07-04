# Dotfiles

Personal dotfiles repository including Vim, Tmux and Bash configuration files. Only Vim 8 and newer is supported.

## Installing

```
git clone --recurse-submodules https://github.com/dboucken/dotfiles.git ~/dotfiles
ln -s ~/dotfiles/inputrc .inputrc
ln -s ~/dotfiles/vimrc .vimrc
ln -s ~/dotfiles/tmux.conf .tmux.conf
echo 'source ~/dotfiles/bashrc' >> ~/.bashrc
mkdir ~/.vim
mkdir ~/.vim/undo
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c "PlugInstall | qa" &> /dev/null
```

## Updating

```
cd ~/dotfiles
git pull
vim -c "PlugClean! | PlugUpgrade | PlugUpdate | qa" &> /dev/null
```
