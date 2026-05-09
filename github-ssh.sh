#!/usr/bin/env bash
set -e

KEY_NAME="${1:-id_ed25519}"
EMAIL="${2:-your_email@example.com}"

SSH_DIR="$HOME/.ssh"
KEY_PATH="$SSH_DIR/$KEY_NAME"

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

if [ -f "$KEY_PATH" ]; then
  echo "SSH key already exists: $KEY_PATH"
  exit 1
fi

echo "Generating SSH key..."

ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH" -N ""

echo "Adding key to ssh-agent and macOS keychain..."

eval "$(ssh-agent -s)"

ssh-add --apple-use-keychain "$KEY_PATH"

cat <<EOF >> "$HOME/.ssh/config"

Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile $KEY_PATH
EOF

chmod 600 "$HOME/.ssh/config"

echo
echo "Done."
echo "Public key:"
echo "-----------------------------------"
cat "$KEY_PATH.pub"
echo "-----------------------------------"
