# Complete ssh/scp/sftp hostnames from known_hosts
if [[ -r ${HOME}/.ssh/known_hosts ]]
then
  _known_hosts=(${${${(f)"$(cat ${HOME}/.ssh/known_hosts)"}%%[, ]*}:#\[*})
  zstyle ':completion:*:(ssh|scp|sftp):*' hosts $_known_hosts
  unset _known_hosts
fi
