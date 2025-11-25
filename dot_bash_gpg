export GPGKEY=CB28C487

# Set GPG_TTY for interactive sessions only
if [ -t 0 ]; then
  export GPG_TTY=$(tty)
fi

# Ensure GPG agent is running
gpg-connect-agent /bye >/dev/null 2>&1
