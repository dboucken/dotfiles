# My dotfiles
My personal dotfiles repository. This is very much unfinished and a continuous work in progress.

It's not a good idea to blindly copy these dotfiles and scripts but feel free to steal some ideas or
send me suggestions or improvements.

## Scripts directory
Scripts to install and update dotfiles and tools on a Linux or a Mac. Look into the scripts for more
info and customization options. After running the scripts your bashrc or bash_profile needs to be
sourced.

```bash
~/dotfiles/scripts/install.sh
~/dotfiles/scripts/update.sh
```

## Test with docker
A docker container that gets initialized with the required packages to test the install and update
scripts and dotfiles.

```bash
docker build -t dotfiles-test -f scripts/Dockerfile . && docker run -it dotfiles-test bash
```
