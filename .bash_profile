# Colour in the CLI and when listing files/directories
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

. ${HOME}/.bash_aliases
. ${HOME}/.bash_autocomplete
. ${HOME}/.bash_aws
. ${HOME}/.bash_functions
. ${HOME}/.bash_git
. ${HOME}/.bash_homebrew
. ${HOME}/.bash_puppet
. ${HOME}/.bash_pythonbrew
. ${HOME}/.bash_rvm
. ${HOME}/.bash_ssh
. ${HOME}/.bash_tmux

# Add local binaries to the PATH
export PATH=${HOME}/bin:${PATH}
