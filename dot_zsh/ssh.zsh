# macOS gives every login session its own ssh-agent socket under /var/run.
# A long-lived tmux server pins whichever socket it inherited at startup and
# hands that path to every pane it spawns, so panes keep pointing at a dead
# agent long after the login session that owned it has gone. Indirecting
# through a fixed path means panes follow the live agent without restarting
# the server.
_ssh_auth_link=${HOME}/.ssh/ssh_auth_sock

# Exit code 2 means "cannot connect"; 1 means "connected, no keys loaded"
_ssh_agent_alive() {
  SSH_AUTH_SOCK=$1 ssh-add -l >/dev/null 2>&1
  [[ $? -ne 2 ]]
}

# Only a shell outside tmux belongs to a real login session, so only it knows
# the current socket. Repoint the link when that socket answers.
if [[ -z ${TMUX} ]] \
  && [[ -S ${SSH_AUTH_SOCK} ]] \
  && [[ ${SSH_AUTH_SOCK} != ${_ssh_auth_link} ]] \
  && _ssh_agent_alive ${SSH_AUTH_SOCK}
then
  ln -sfn ${SSH_AUTH_SOCK} ${_ssh_auth_link}
fi

[[ -S ${_ssh_auth_link} ]] && export SSH_AUTH_SOCK=${_ssh_auth_link}
unset _ssh_auth_link
unfunction _ssh_agent_alive

# Complete ssh/scp/sftp hostnames from known_hosts
if [[ -r ${HOME}/.ssh/known_hosts ]]
then
  _known_hosts=(${${${(f)"$(cat ${HOME}/.ssh/known_hosts)"}%%[, ]*}:#\[*})
  zstyle ':completion:*:(ssh|scp|sftp):*' hosts $_known_hosts
  unset _known_hosts
fi
