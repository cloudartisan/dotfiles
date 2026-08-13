# Load API keys and secrets from ~/.keys directory
# IMPORTANT: Keys are never committed to this repository
# They are loaded from local files in ~/.keys

# Create keys directory if it doesn't exist
[[ -d "${HOME}/.keys" ]] || mkdir -p "${HOME}/.keys"

# Load all .sh files from ~/.keys directory
if [[ -d "${HOME}/.keys" ]]; then
  for keyfile in "${HOME}"/.keys/*.sh(N); do
    if [[ -f "${keyfile}" ]]; then
      source "${keyfile}"
    fi
  done
fi

# Add a helper function to create key files safely
keys_add() {
  local key_name="$1"
  local key_value="$2"
  local key_file

  if [[ -z "${key_name}" ]]; then
    echo "Usage: keys_add KEY_NAME [KEY_VALUE]"
    echo "Example: keys_add GITHUB_TOKEN abcd1234"
    echo "Omit KEY_VALUE to be prompted for it without echoing, which also"
    echo "keeps the secret out of ~/.zsh_history."
    return 1
  fi

  # Reject anything that is not a valid shell identifier, so a typo cannot
  # produce a key file that fails to parse when sourced.
  if [[ ! "${key_name}" =~ '^[A-Za-z_][A-Za-z0-9_]*$' ]]; then
    echo "Invalid key name: ${key_name}"
    return 1
  fi

  # Prompt when no value is given. Passing the value on the command line
  # records it verbatim in ~/.zsh_history (HIST_IGNORE_SPACE is not set), so
  # the prompt is the safer path.
  if [[ -z "${key_value}" ]]; then
    read -rs "key_value?Value for ${key_name}: "
    echo
  fi

  if [[ -z "${key_value}" ]]; then
    echo "No value given; nothing written."
    return 1
  fi

  key_file="${HOME}/.keys/${key_name:l}.sh"

  # Write inside a subshell with a restrictive umask so the file is never
  # briefly world-readable between creation and chmod.
  #
  # %q quotes the value so it survives sourcing exactly as given. Writing it
  # unquoted truncates values containing spaces, and lets $(...) or backticks
  # execute when the file is sourced - which ~/.zshenv now does for every zsh
  # invocation, not just interactive ones.
  (
    umask 077
    printf 'export %s=%q\n' "${key_name}" "${key_value}" > "${key_file}"
  )
  chmod 600 "${key_file}"

  # Source it immediately
  source "${key_file}"

  echo "${key_name} added and loaded successfully."
}
