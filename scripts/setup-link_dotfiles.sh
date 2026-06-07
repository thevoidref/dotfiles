#!/usr/bin/env bash
# setup-link_dotfiles.sh

set -euo pipefail

if [[ $# -ge 1 ]]; then
  USERNAME="$1"
elif [[ $EUID -eq 0 ]]; then
  echo "Usage: $0 <username>"
  exit 1
else
  USERNAME="$(id -un)"
fi

TARGET_HOME="$(getent passwd "$USERNAME" | cut -d: -f6)"
DOTFILES="$TARGET_HOME/.dotfiles"
TARGET="$TARGET_HOME"

find "$DOTFILES" \
  -not -path "$DOTFILES/.git/*" \
  -not -path "$DOTFILES/scripts/*" \
  -not -path "$DOTFILES/prompts/*" \
  -not -path "$DOTFILES/nixos/*" \
  -not -name "README.md" \
  -not -name ".gitignore" \
  -type f | while read -r src; do

  rel="${src#$DOTFILES/}"
  dst="$TARGET/$rel"

  mkdir -p "$(dirname "$dst")"

  if [[ -e "$dst" || -L "$dst" ]]; then
    echo "  replacing: $dst"
    rm "$dst"
  fi

  ln -s "$src" "$dst"
  echo "  linked: $rel"
done

echo ""
echo "Done. $(find $DOTFILES -not -path '$DOTFILES/.git/*' -not -name 'link.sh' -not -name 'README.md' -not -name '.gitignore' -type f | wc -l) files linked."
