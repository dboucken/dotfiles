# My dotfiles
Personal dotfiles repository. This is very much unfinished and a continuous work in progress.

It's not a good idea to blindly take over these dotfiles and scripts but feel free to steal some
ideas or send me suggestions or improvements.

## Dotfiles directory
Contains all dotfiles.

## Scripts directory
Contains helpful scripts to install, update and uninstall dotfiles and extra tools on a Linux or a
Mac. Look into the scripts for more info and customization options. Source your .bashrc or
.bash_profile after running the scripts to make sure the effects take place.

### Install
`~/dotfiles/scripts/install.sh`

### Update
`~/dotfiles/scripts/update.sh`

### Uninstall
`~/dotfiles/scripts/uninstall.sh`

## Test with docker
Docker container that gets initialized with the required packages to test the install, update and
uninstall scripts.

`docker build -t dotfiles-test . && docker run -it dotfiles-test bash`
