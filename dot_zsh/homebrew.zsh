export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Add Homebrew-provided completions to fpath (must happen before compinit)
if type brew &>/dev/null
then
  fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi
