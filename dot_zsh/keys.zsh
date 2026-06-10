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

  if [[ -z "${key_name}" || -z "${key_value}" ]]; then
    echo "Usage: keys_add KEY_NAME KEY_VALUE"
    echo "Example: keys_add GITHUB_TOKEN abcd1234"
    return 1
  fi

  # Create the key file (zsh lowercasing via :l)
  echo "export ${key_name}=${key_value}" > "${HOME}/.keys/${key_name:l}.sh"
  chmod 600 "${HOME}/.keys/${key_name:l}.sh"

  # Source it immediately
  source "${HOME}/.keys/${key_name:l}.sh"

  echo "${key_name} added and loaded successfully."
}
