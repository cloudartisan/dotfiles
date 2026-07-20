# Volta manages Node/npm/yarn on a per-project basis (mirrors pyenv in
# python.zsh). Sourced after homebrew.zsh so $VOLTA_HOME/bin sits ahead of
# /opt/homebrew/bin and Volta's shims win over the brew-installed node.
export VOLTA_HOME="${HOME}/.volta"
export PATH="${VOLTA_HOME}/bin:${PATH}"
