#!/usr/bin/env bash
# noctalia-theme_sync.sh

# VS Code / VSCodium theming
STORE_PATH=$(find /nix/store -maxdepth 1 -type d \
    | grep -E '/[a-z0-9]+-noctalia-shell-[0-9.]+$' \
    | head -n1)
TEMPLATE_PROCESSOR="$STORE_PATH/share/noctalia-shell/Scripts/python/src/theming/template-processor.py"
TEMPLATE="$STORE_PATH/share/noctalia-shell/Assets/Templates/code.json"

THEMES=()

# VS Code extension
VSCODE_THEME=$(find ~/.vscode/extensions \
    -maxdepth 3 \
    -name "NoctaliaTheme-color-theme.json" \
    -path "*/noctalia.noctaliatheme-*" \
    2>/dev/null | head -1)

if [ -n "$VSCODE_THEME" ]; then
    THEMES+=("$VSCODE_THEME")
fi

# VSCodium extension
VSCODIUM_THEME=$(find ~/.vscode-oss/extensions \
    -maxdepth 3 \
    -name "NoctaliaTheme-color-theme.json" \
    -path "*/noctalia.noctaliatheme-*" \
    2>/dev/null | head -1)

if [ -n "$VSCODIUM_THEME" ]; then
    THEMES+=("$VSCODIUM_THEME")
fi

# Nothing found
if [ ${#THEMES[@]} -eq 0 ]; then
    echo "No NoctaliaTheme extension found in VS Code or VSCodium." >&2
    exit 1
fi

# Render all found themes
for THEME in "${THEMES[@]}"; do
    echo "Applying theme: $THEME"

    python3 "$TEMPLATE_PROCESSOR" \
        --scheme ~/.cache/noctalia/predefined-scheme.json \
        --mode dark \
        --render "$TEMPLATE:$THEME"
done

# Starship theming, as long as the palette is 41 colors long
STARSHIP_CONFIG="$HOME/.dotfiles/.config/starship.toml"
TMP_CONFIG="$STARSHIP_CONFIG.tmp"
STARSHIP_PALETTE="$HOME/.cache/noctalia/starship-palette.toml"

{ head -n -41 "$STARSHIP_CONFIG"; cat "$STARSHIP_PALETTE"; } > "$TMP_CONFIG" && \
mv "$TMP_CONFIG" "$STARSHIP_CONFIG" && \
pkill -SIGHUP foot
