#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/.dotfiles"
TARGET="$HOME"

find "$DOTFILES" \
  -not -path "$DOTFILES/.git/*" \
  -not -name "link.sh" \
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
