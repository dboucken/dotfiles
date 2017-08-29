# Exports
export TERM=screen-256color

# Aliases
alias l="ls -la"

# Functions
# Extract all compressed file types (credit https://github.com/xvoland/Extract)
function extract {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
        echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    else
        for n in $@
        do
            if [ -f "$n" ] ; then
                case "${n%,}" in
                    *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                        tar xvf "$n"       ;;
                    *.lzma)      unlzma ./"$n"      ;;
                    *.bz2)       bunzip2 ./"$n"     ;;
                    *.rar)       unrar x -ad ./"$n" ;;
                    *.gz)        gunzip ./"$n"      ;;
                    *.zip)       unzip ./"$n"       ;;
                    *.z)         uncompress ./"$n"  ;;
                    *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                        7z x ./"$n"        ;;
                    *.xz)        unxz ./"$n"        ;;
                    *.exe)       cabextract ./"$n"  ;;
                    *)
                        echo "extract: '$n' - unknown archive method"
                        return 1
                        ;;
                esac
            else
                echo "'$n' - file does not exist"
                return 1
            fi
        done
    fi
}

# Download. build and install Tmux and Vim in the tools directory
tools_dir="tools"
tmux_dir="tmux"
vim_dir="vim"

function install_tools {
    echo "install tools"
}

function uninstall_tools {
    echo "uninstall tools"
}

function update_tools {
    cd ~

    # Tools directory must exist
    if [ ! -d "$tools_dir" ]; then
        echo "~/$tools_dir not found"
        return
    fi

    cd $tools_dir

    # Update tmux
    if [ -d "$tmux_dir" ]; then
        echo " "
        echo "################################################################################"
        echo "# Update Tmux                                                                  #"
        echo "################################################################################"

        cd $tmux_dir

        echo " "
        echo "--------------------------------------------------------------------------------"
        echo " Get updates"
        echo "--------------------------------------------------------------------------------"
        git checkout master
        git pull

        echo " "
        echo "--------------------------------------------------------------------------------"
        echo " Get latest tag (git describe --tags --abbrev=0)"
        echo "--------------------------------------------------------------------------------"
        local latest_tag=$(git describe --tags --abbrev=0)
        echo "Checking out latest tag: $latest_tag"
        git checkout $latest_tag

        echo " "
        echo "--------------------------------------------------------------------------------"
        echo " Build (make)"
        echo "--------------------------------------------------------------------------------"
        make

        echo " "
        echo "--------------------------------------------------------------------------------"
        echo " Install (sudo make install)"
        echo "--------------------------------------------------------------------------------"
        sudo make install
    fi

    cd ~
    cd $tools_dir

    # Update vim
    if [ -d "$vim_dir" ]; then
        echo " "
        echo "################################################################################"
        echo "# Update Vim                                                                   #"
        echo "################################################################################"

        cd $vim_dir

        echo " "
        echo "--------------------------------------------------------------------------------"
        echo " Get updates (git pull)"
        echo "--------------------------------------------------------------------------------"
        git pull

        echo " "
        echo "--------------------------------------------------------------------------------"
        echo " Build (make)"
        echo "--------------------------------------------------------------------------------"
        make

        echo " "
        echo "--------------------------------------------------------------------------------"
        echo " Install (sudo make install)"
        echo "--------------------------------------------------------------------------------"
        sudo make install

        echo " "
        echo "--------------------------------------------------------------------------------"
        echo " Update Vim Plugins (vim +PlugUpdate +PlugUpgrade +qall)"
        echo "--------------------------------------------------------------------------------"
        vim +PlugUpdate +PlugUpgrade +qall
    fi

    cd ~

    echo " "
    echo "################################################################################"
    echo "# Update finished                                                              #"
    echo "################################################################################"
}
