# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
    eval "$("$BASE16_SHELL/profile_helper.sh")"

# Usefull aliases
alias ll="ls -lhFA"
alias l="ls -lhF"

# Use Vim as a default editor
export EDITOR=vim
export VISUAL=$EDITOR
