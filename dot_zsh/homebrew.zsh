export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Leave self-updating apps (auto_updates casks) to their own updaters. Modern
# brew upgrade reinstalls them by default, which churns large re-downloads and
# can transiently downgrade an app whose updater is ahead of the Homebrew cask.
export HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS=1

# Add Homebrew-provided completions to fpath (must happen before compinit)
if type brew &>/dev/null
then
  fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi
