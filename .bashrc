# Exports
export TERM=xterm-256color

# Aliases
alias l="ls -lhFA"

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

# Set links for the dotfiles
function install_dotfiles {
    cd ~

    # Backup existing dotfiles
    if [ -f ".vimrc" ]; then
        mv -vf .vimrc .vimrc.bak
    fi
    if [ -f ".tmux.conf" ]; then
        mv -vf .tmux.conf .tmux.conf.bak
    fi
    if [ -f ".inputrc" ]; then
        mv -vf .inputrc .inputrc.bak
    fi

    # Link to new dotfiles
    ln -sv dotfiles/.vimrc
    ln -sv dotfiles/.tmux.conf
    ln -sv dotfiles/.inputrc
}

function uninstall_dotfiles {
    cd ~

    # Remove links
    if [ -h ".vimrc" ]; then
        rm -vf .vimrc
    fi
    if [ -h ".tmux.conf" ]; then
        rm -vf .tmux.conf
    fi
    if [ -h ".inputrc" ]; then
        rm -vf .inputrc
    fi

    # Restore backups
    if [ -f ".vimrc.bak" ]; then
        mv -vf .vimrc.bak .vimrc
    fi
    if [ -f ".tmux.conf.bak" ]; then
        mv -vf .tmux.conf.bak .tmux.conf
    fi
    if [ -f ".inputrc.bak" ]; then
        mv -vf .inputrc.bak .inputrc
    fi
}

# Download. build and install Tmux and Vim in the tools directory
tools_dir="tools"
tmux_dir="tmux"
vim_dir="vim"

function install_tools {
    cd ~

    # Create tools dir if it does not exist
    if [ ! -d "$tools_dir" ]; then
        mkdir $tools_dir
    fi

    cd $tools_dir

    if [ ! -d "$tmux_dir" ]; then
        echo " "
        echo "################################################################################"
        echo "# Install Tmux                                                                 #"
        echo "################################################################################"
        git clone https://github.com/tmux/tmux.git $tmux_dir
        cd $tmux_dir
        local latest_tag=$(git describe --tags --abbrev=0)
        git checkout $latest_tag
        sh autogen.sh && ./configure && make && sudo make install
    fi

    cd ~
    cd $tools_dir

    if [ ! -d "$vim_dir" ]; then
        echo " "
        echo "################################################################################"
        echo "# Update Vim                                                                   #"
        echo "################################################################################"
        git clone https://github.com/vim/vim.git $vim_dir
        cd $vim_dir
        ./configure --with-features=huge && make && chmod a+rwx runtime/doc && sudo make install

        echo " "
        echo "--------------------------------------------------------------------------------"
        echo " Install Vim Plugins (vim +PlugUpdate +PlugUpgrade +qall)"
        echo "--------------------------------------------------------------------------------"
        vim +PlugUpdate +PlugUpgrade +qall
    fi

    cd ~

    echo " "
    echo "################################################################################"
    echo "# Install finished                                                             #"
    echo "################################################################################"
}

function uninstall_tools {
    cd ~

    # Tools directory must exist
    if [ ! -d "$tools_dir" ]; then
        echo "~/$tools_dir not found"
        return
    fi

    cd $tools_dir

    if [ -d "$tmux_dir" ]; then
        echo " "
        echo "################################################################################"
        echo "# Uninstall Tmux                                                               #"
        echo "################################################################################"
        cd $tmux_dir
        sudo make uninstall
        cd ..
        rm -rf $tmux_dir
    fi

    cd ~
    cd $tools_dir

    if [ -d "$vim_dir" ]; then
        echo " "
        echo "################################################################################"
        echo "# Uninstall Vim                                                                #"
        echo "################################################################################"
        cd $vim_dir
        sudo make uninstall
        cd ..
        rm -rf $vim_dir
    fi

    cd ~

    # Remove vim related directories and files in the home directory
    if [ -d ".vim" ]; then
        rm -rfv .vim
    fi

    if [ -f ".viminfo" ]; then
        rm -rfv .viminfo
    fi

    echo " "
    echo "################################################################################"
    echo "# Uninstall finished                                                           #"
    echo "################################################################################"
}

function update_tools {
    cd ~

    # Tools directory must exist
    if [ ! -d "$tools_dir" ]; then
        echo "~/$tools_dir not found"
        return
    fi

    cd $tools_dir

    if [ -d "$tmux_dir" ]; then
        echo " "
        echo "################################################################################"
        echo "# Update Tmux                                                                  #"
        echo "################################################################################"
        cd $tmux_dir

        # Get current version
        local current_tag=$(git describe --tags --abbrev=0)
        echo "Current tag: $current_tag"

        # Update repo
        git checkout master
        git pull

        # Get new version
        local latest_tag=$(git describe --tags --abbrev=0)
        echo "Latest tag: $latest_tag"
        git checkout $latest_tag

        # Build and install if there is a new version
        if [ "$current_tag" != "$latest_tag" ]; then
            make && sudo make install
        fi
    fi

    cd ~
    cd $tools_dir

    if [ -d "$vim_dir" ]; then
        echo " "
        echo "################################################################################"
        echo "# Update Vim                                                                   #"
        echo "################################################################################"
        cd $vim_dir

        # Get current version
        local current_tag=$(git describe --all)
        echo "Current tag: $current_tag"

        # Update repo
        git pull

        # Get new version
        local latest_tag=$(git describe --all)
        echo "Latest tag: $latest_tag"

        # Build and install if there is a new version
        if [ "$current_tag" != "$latest_tag" ]; then
            make && sudo make install
        fi

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
