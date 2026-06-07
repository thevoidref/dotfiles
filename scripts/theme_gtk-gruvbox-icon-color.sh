#!/usr/bin/env bash
# theme_gtk-gruvbox-icon-color.sh

set -euo pipefail

# Configuration Parameters
COLOR="${1:-blue}"
ICON_DIR="$HOME/.local/share/icons"
REPO_DIR="$ICON_DIR/gruvbox-plus-icon-pack"
TARGET_PATH="$ICON_DIR/Gruvbox-Plus-Dark"
REPO_URL="https://github.com/SylEleuth/gruvbox-plus-icon-pack.git"

echo "=== System Check ==="
for cmd in git dconf; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: '$cmd' is required. Install it via environment.systemPackages first."
        exit 1
    fi
done

# 1. Clone or update repo
mkdir -p "$ICON_DIR"
if [ -d "$REPO_DIR" ]; then
    echo "Existing icon pack detected. Pulling latest updates..."
    git -C "$REPO_DIR" pull
else
    echo "Cloning Gruvbox Plus Icon Pack into user space..."
    git clone "$REPO_URL" "$REPO_DIR"
fi

# 2. Symlink theme directory to expected XDG path
if [ -d "$TARGET_PATH" ] && [ ! -L "$TARGET_PATH" ]; then
    rm -rf "$TARGET_PATH"
fi
ln -sfn "$REPO_DIR/Gruvbox-Plus-Dark" "$TARGET_PATH"

# 3. Execute Upstream Color Chooser Utility
chmod +x "$REPO_DIR/scripts/folders-color-chooser"
echo "Applying folder color: $COLOR"
cd "$REPO_DIR/scripts"
if ! bash folders-color-chooser -c "$COLOR"; then
    echo "Error: Invalid color selection."
    echo "Available colors:"
    bash folders-color-chooser -l
    exit 1
fi

# 4. Register theme and flush caches
echo "Registering theme and flushing caches..."
dconf write /org/gnome/desktop/interface/icon-theme "'Gruvbox-Plus-Dark'"
nix-shell -p gtk3 --run "gtk-update-icon-cache -f -t '$TARGET_PATH'" || true
rm -rf "$HOME/.cache/icon-theme.cache"
rm -rf "$HOME/.cache/thunar"
pkill -9 thunar || true

echo "=== Success ==="
echo "Folder color set to '$COLOR'. Open Thunar to verify."
