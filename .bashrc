# --------------------------------------------------------------------------------------------------
# Settings
# --------------------------------------------------------------------------------------------------
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
alias tmuxd='tmux new -A -s tmux'
alias vim_plug_update='vim +"PlugClean!" +"PlugInstall" +"PlugUpgrade" +"PlugUpdate" +qall &> /dev/null'
alias nvim_plug_update='nvim +"PlugClean!" +"PlugInstall" +"PlugUpgrade" +"PlugUpdate" +qall &> /dev/null'
