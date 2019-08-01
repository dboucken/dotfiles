# Dotfiles

Personal dotfiles repository including Vim, Tmux and Bash configuration files. Only Vim 8 and newer is supported.

## Installing

```
git clone https://github.com/dboucken/dotfiles.git ~/dotfiles
cd ~/dotfiles
git submodule init
ln -s ~/dotfiles/inputrc .inputrc
ln -s ~/dotfiles/vimrc .vimrc
ln -s ~/dotfiles/tmux.conf .tmux.conf
ln -s ~/dotfiles/vim .vim
echo 'source ~/dotfiles/bashrc' >> ~/.bashrc
mkdir -p ~/.vim/undo
```

## Updating

```
cd ~/dotfiles
git pull
git submodule update --remote --merge
```

## Add a VIM plugin

```
cd ~/dotfiles
git submodule add <repo> vim/pack/plugins/start/<name>
git commit -am "Add VIM plugin"
```

## Remove a VIM plugin

```
cd ~/dotfiles
git submodule deinit vim/pack/plugins/start/<name>
git rm vim/pack/plugins/start/<name>
rm -Rf .git/modules/vim/pack/plugins/start/<name>
git commit -am "Remove VIM plugin"
```
