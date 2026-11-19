#!/usr/bin/env bash
# setup-link_dotfiles.sh — symlink every dotfile into $HOME
set -euo pipefail

USERNAME="${1:-}"
if [[ -z "$USERNAME" ]]; then
  [[ $EUID -eq 0 ]] && { echo "Usage: $0 <username>"; exit 1; }
  USERNAME="$(id -un)"
fi

HOME_DIR="$(getent passwd "$USERNAME" | cut -d: -f6)"
DOTFILES="$HOME_DIR/.dotfiles"
count=0

while IFS= read -r -d '' src; do
  rel="${src#"$DOTFILES"/}"
  dst="$HOME_DIR/$rel"
  mkdir -p "$(dirname "$dst")"
  ln -sfn "$src" "$dst"
  echo "  linked: $rel"
  count=$((count + 1))
done < <(find "$DOTFILES" -type f \
  -not -path "$DOTFILES/.git/*" \
  -not -path "$DOTFILES/scripts/*" \
  -not -path "$DOTFILES/strings/*" \
  -not -name "README.md" \
  -not -name ".gitignore" \
  -print0)

echo "Done. $count files linked."
