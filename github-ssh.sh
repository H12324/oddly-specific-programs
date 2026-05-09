#!/usr/bin/env bash
set -e

KEY_NAME="${1:-id_ed25519}"
EMAIL="${2:-your_email@example.com}"
SSH_DIR="$HOME/.ssh"
KEY_PATH="$SSH_DIR/$KEY_NAME"

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

if [ -f "$KEY_PATH" ]; then
  echo "Key already exists: $KEY_PATH"
  exit 1
fi

ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH" -N ""

eval "$(ssh-agent -s)"
ssh-add "$KEY_PATH"

echo
echo "SSH key created:"
echo "$KEY_PATH"
echo
echo "Public key:"
cat "$KEY_PATH.pub"
