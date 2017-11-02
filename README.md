# My dotfiles
Personal dotfiles repository. Feel free to steal ideas or send me suggestions. This is very much
unfinished and a continuous work in progress.

## Dotfiles directory
Contains all dotfiles.

## Scripts directory
Contains helpful scripts to install, update and uninstall dotfiles and extra tools on a linux or a
mac. Look into the scripts for more info and customization options. Source your .bashrc or
.bash_profile after running the scripts to make sure the effects take place.

### Installation
`~/dotfiles/scripts/install.sh`

### Update
`~/dotfiles/scripts/update.sh`

### Uninstallation
`~/dotfiles/scripts/uninstall.sh`

## Test with docker
Docker container that gets initialized with the required packages to test the installation, update
and uninstallation scripts.

`docker build -t dotfiles-test . && docker run -it dotfiles-test bash`
