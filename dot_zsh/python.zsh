export PYTHON_CONFIGURE_OPTS="--enable-framework"

if type pyenv &>/dev/null; then
  eval "$(pyenv init -)"
fi

if type pyenv-virtualenv-init &>/dev/null; then
  eval "$(pyenv virtualenv-init -)"
fi
