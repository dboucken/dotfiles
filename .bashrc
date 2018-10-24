# --------------------------------------------------------------------------------------------------
# Settings
# --------------------------------------------------------------------------------------------------
export TERM=xterm-256color

# Use VIM as default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Change the prompt string to the current complete path
PS1="\w > "

# --------------------------------------------------------------------------------------------------
# Aliases
# --------------------------------------------------------------------------------------------------
alias ll="ls -lhFA"
alias l="ls -lhF"
alias c="clear"
alias r="source ~/.bash_profile 2> /dev/null && source ~/.bashrc 2> /dev/null"
