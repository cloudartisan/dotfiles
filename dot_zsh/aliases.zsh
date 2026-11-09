alias hgrep="history | grep -v grep | grep "

# Claude Code terminal detection fix for tmux
# Preserves actual terminal identity when running inside tmux
# Enables /terminal-setup command to work within tmux sessions
alias claude='TERM_PROGRAM=iTerm.app claude'

# Keep the Mac fully awake (display, system, disk) until interrupted.
# Accepts caffeinate's usual arguments, e.g. "awake -t 3600" or "awake make".
alias awake="caffeinate -dimsu"

# Power-cycle the Wi-Fi radio, which can recover a stuck connection without
# a reboot. Finds the Wi-Fi device rather than assuming en0, since it is en1
# on some Macs. Optional argument: seconds to stay off (default 5).
wifi-reset() {
  local dev
  dev="$(networksetup -listallhardwareports |
    awk '/^Hardware Port: Wi-Fi/ { getline; print $2; exit }')"
  if [[ -z "$dev" ]]; then
    print -u2 "wifi-reset: no Wi-Fi device found"
    return 1
  fi
  networksetup -setairportpower "$dev" off &&
    sleep "${1:-5}" &&
    networksetup -setairportpower "$dev" on
}

# Chezmoi aliases
alias cz="chezmoi"
alias cza="chezmoi apply"
alias czd="chezmoi diff"
alias cze="chezmoi edit"
alias czu="chezmoi update"
