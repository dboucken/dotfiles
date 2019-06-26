# --------------------------------------------------------------------------------------------------
# Settings
# --------------------------------------------------------------------------------------------------
export EDITOR=vim
export VISUAL=$EDITOR

# Change the prompt string to the current complete path
PS1="\w > "

# --------------------------------------------------------------------------------------------------
# Aliases
# --------------------------------------------------------------------------------------------------
alias ll="ls -lhFA"
alias l="ls -lhF"
alias c="clear"
alias r="source ~/.bash_profile 2> /dev/null && source ~/.bashrc 2> /dev/null"
alias tmuxd='tmux new -A -s tmux'
alias plug_update_vim='vim +"PlugClean!" +"PlugInstall!" +"PlugUpgrade!" +"PlugUpdate!" +qall &> /dev/null'
