alias hgrep="history | grep -v grep | grep "

# Claude Code terminal detection fix for tmux
# Preserves actual terminal identity when running inside tmux
# Enables /terminal-setup command to work within tmux sessions
alias claude='TERM_PROGRAM=iTerm.app claude'

# Keep the Mac fully awake (display, system, disk) until interrupted.
# Accepts caffeinate's usual arguments, e.g. "awake -t 3600" or "awake make".
alias awake="caffeinate -dimsu"

# Chezmoi aliases
alias cz="chezmoi"
alias cza="chezmoi apply"
alias czd="chezmoi diff"
alias cze="chezmoi edit"
alias czu="chezmoi update"
