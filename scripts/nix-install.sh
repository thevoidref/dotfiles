#!/usr/bin/env bash
# nix-install.sh
set -euo pipefail

FOLDER="${1:-main}"
INSTALLATION="$(realpath "$HOME/Code/Nixos/$FOLDER")"
TARGET="/etc/nixos"

if [[ ! -d "$INSTALLATION" ]]; then
  echo "Error: '$INSTALLATION' does not exist or is not a directory." >&2
  exit 1
fi

echo "Linking $INSTALLATION -> $TARGET..."
sudo ln -sfn "$INSTALLATION" "$TARGET"
echo "Done."