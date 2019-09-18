# Dotfiles

Personal dotfiles repository including Vim, Tmux and Bash configuration files. Only Vim 8 and newer is supported.

## Installing

```
git clone https://github.com/dboucken/dotfiles.git ~/dotfiles
ln -s ~/dotfiles/inputrc .inputrc
ln -s ~/dotfiles/tmux.conf .tmux.conf
ln -s ~/dotfiles/vim .vim
mkdir -p ~/.vim/undo
cd ~/dotfiles
git submodule init
git submodule update --remote --merge
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
