#!/usr/bin/env bash
# sync-dotfiles.sh — symlink every dotfile into $HOME, then purge dead links in .config
set -euo pipefail

[[ $EUID -eq 0 ]] && { echo "Run as user, not root."; exit 1; }

DOTFILES="$HOME/.dotfiles"
CONFIG="$HOME/.config"
count=0

# Link
while IFS= read -r -d '' src; do
  rel="${src#"$DOTFILES"/}"
  dst="$HOME/$rel"
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

# Purge: dead links to dotfiles, then empty dirs in .config
find "$CONFIG" -xtype l -lname "$DOTFILES/*" -print -delete | sed 's/^/  removed link: /'
find "$CONFIG" -mindepth 1 -type d -empty -print -delete | sed 's/^/  removed dir: /'

echo "Done. $count files linked."