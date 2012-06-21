# Colour in the CLI and when listing files/directories
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

. ${HOME}/.bash_functions
. ${HOME}/.bash_autocomplete
. ${HOME}/.bash_git
. ${HOME}/.bash_ssh
. ${HOME}/.bash_homebrew
. ${HOME}/.bash_aws
. ${HOME}/.bash_tmux
. ${HOME}/.bash_puppet
. ${HOME}/.bash_pythonbrew

# Add local binaries to the PATH
export PATH=${HOME}/bin:${PATH}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
