# Dotfiles

Personal dotfiles repository including Vim, Tmux and Bash configuration files. Only Vim 8 and newer is supported. Vim plugins are included using git submodules.

## Installing

```
git clone --recurse-submodules https://github.com/dboucken/dotfiles.git ~/dotfiles

ln -s ~/dotfiles/inputrc .inputrc
ln -s ~/dotfiles/vimrc .vimrc
ln -s ~/dotfiles/tmux.conf .tmux.conf
ln -s ~/dotfiles/vim .vim

vim -c "silent! helptags ALL | qa" &> /dev/null
```

## Updating

```
cd ~/dotfiles

git pull --recurse-submodules
git submodule update --recursive --remote

vim -c "silent! helptags ALL | qa" &> /dev/null
```

## Adding a Vim plugin

```
cd ~/dotfiles

git submodule add <git@github ...> vim/pack/plugins/start/<submodule>
```

## Removing a Vim plugin

```
cd ~/dotfiles

git submodule deinit -f -- vim/pack/plugins/start/<submodule>   
rm -rf .git/modules/vim/pack/plugins/start/<submodule>
git rm -f vim/pack/plugins/start/<submodule>
```
