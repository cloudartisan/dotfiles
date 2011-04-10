# Standard PATH magic
export PATH=$PATH:/usr/local/bin:/usr/local/bin:$HOME/bin

# Colour in the CLI and when listing files/directories
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

. $HOME/.bash_functions
. $HOME/.bash_aliases
. $HOME/.bash_git
. $HOME/.bash_ssh
. $HOME/.bash_aws

# Get RVM configured
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Enable bash auto-completion magic
if [ -f `brew --prefix`/etc/bash_completion ]; then
	. `brew --prefix`/etc/bash_completion
fi

# Tab through completion matches
#bind '"\t":menu-complete'
