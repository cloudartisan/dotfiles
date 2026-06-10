# Prefer Homebrew vim over the system one
if [[ -x /opt/homebrew/bin/vim ]]
then
  alias vim='/opt/homebrew/bin/vim'
  alias vi='/opt/homebrew/bin/vim'
  alias v='/opt/homebrew/bin/vim'
fi
