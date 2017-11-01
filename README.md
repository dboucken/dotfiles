# My dotfiles
Personal dotfiles repository. Feel free to steal ideas or send me suggestions. This is very much
unfinished and a continuous work in progress.

## Installation
`echo source ~/dotfiles/.bashrc >> .bashrc`

`~/dotfiles/scripts/install.sh` or `~/dotfiles/scripts/mac_install.sh`

## Update
`~/dotfiles/scripts/install.sh` or `~/dotfiles/scripts/mac_install.sh`

## Uninstallation
`~/dotfiles/scripts/uninstall.sh`

## Test with docker
`docker build -t dotfiles-test . && docker run -it dotfiles-test bash`
