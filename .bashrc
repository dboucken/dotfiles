# --------------------------------------------------------------------------------------------------
# Exports
# --------------------------------------------------------------------------------------------------
export TERM=xterm-256color

# --------------------------------------------------------------------------------------------------
# Aliases
# --------------------------------------------------------------------------------------------------
alias l="ls -lhFA"
alias c="clear"
alias install_tools="~/dotfiles/install.sh"
alias update_tools="~/dotfiles/update.sh"
alias uninstall_tools="~/dotfiles/uninstall.sh"

# --------------------------------------------------------------------------------------------------
# Git
# --------------------------------------------------------------------------------------------------
# Configure git completion and git prompt
source ~/git-completion.bash
source ~/git-prompt.sh
GIT_PS1_SHOWUPSTREAM=auto
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_STATESEPARATOR=' '
export PROMPT_COMMAND='__git_ps1 "\w" " > "'

# --------------------------------------------------------------------------------------------------
# Functions
# --------------------------------------------------------------------------------------------------
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

# Reload bash_profile and/or bashrc
function reload {
    cd ~
    if [ -f ".bash_profile" ]; then
        source ~/.bash_profile
        echo "source ~/.bash_profile"
    fi
    if [ -f ".bashrc" ]; then
        source ~/.bashrc
        echo "source ~/.bashrc"
    fi
}
