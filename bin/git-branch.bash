function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}")"
}

BRIGHT_RED="\[\033[1;31m\]"
DULL_WHITE="\[\033[0;37m\]"
BRIGHT_WHITE="\[\033[1;37m\]"
GRAY="\[\033[1;30m\]"
LIGHT_GRAY="\[\033[0;37m\]"
CYAN="\[\033[0;36m\]"
LIGHT_CYAN="\[\033[1;36m\]"
NO_COLOUR="\[\033[0m\]"

PS1="${NO_COLOUR}\h:\w ${BRIGHT_RED}\$(parse_git_branch)${NO_COLOUR}\$ "
