# My dotfiles
Personal dotfiles repository. Feel free to steal ideas or send me suggestions. This is very much
unfinished and a continious work in progress.

## Installation
`echo source ~/dotfiles/.bashrc >> .bashrc`

`~/dotfiles/install.sh` or `~/dotfiles/mac_install.sh`

## Update
`~/dotfiles/install.sh` or `~/dotfiles/mac_install.sh`

## Uninstallation
`~/dotfiles/uninstall.sh`

## Test with docker
`docker build -t dotfiles-test . && docker run -it dotfiles-test bash`
