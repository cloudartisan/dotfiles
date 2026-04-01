#!/bin/bash
# Modify script that preserves tool-managed sections in .bash_profile
# This runs when chezmoi applies changes, merging chezmoi content with tool additions

target_file="$HOME/.bash_profile"

# Read the chezmoi-managed content from stdin
chezmoi_content=$(cat)

# Output the chezmoi-managed content first
echo "$chezmoi_content"

# If the target file exists, extract and preserve tool-managed sections
if [ -f "$target_file" ]; then
  # Extract aisuite section if it exists
  if grep -q "# >>> aisuite >>>" "$target_file"; then
    echo ""
    sed -n '/# >>> aisuite >>>/,/# <<< aisuite <<</p' "$target_file"
  fi

  # Extract devbar section if it exists
  if grep -q "# devbar-managed-start" "$target_file"; then
    sed -n '/# devbar-managed-start/,/# devbar-managed-end/p' "$target_file"
  fi
fi
